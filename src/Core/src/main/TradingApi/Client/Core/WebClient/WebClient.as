package TradingApi.Client.Core.WebClient
{
	import TradingApi.Client.Core.TradingAPIConnection;
	
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.Base64Encoder;
	
	[Event(type="WebClient_webReponseEvent", type="mx.rpc.events.ResultEvent")]
	public class WebClient extends EventDispatcher
	{
		public static const WEB_RESPONSE_EVENT:String = "WebClient_webReponseEvent"; 

		private var _http:HTTPService;
		private var _tradingAPIConnection:TradingAPIConnection;
		
		public function get TradingApiConnection():TradingAPIConnection {return _tradingAPIConnection;}
		public function set TradingApiConnection(value:TradingAPIConnection):void {_tradingAPIConnection = value;}
		
		public function WebClient(tradingAPIConnection:TradingAPIConnection)
		{
			_tradingAPIConnection = tradingAPIConnection;
			
			_http = new HTTPService();
			_http.contentType = HTTPService.CONTENT_TYPE_FORM;
			_http.concurrency = "multiple";
			_http.requestTimeout = 60;
  		 	_http.resultFormat = "text";
			_http.addEventListener(ResultEvent.RESULT, OnWebResponse, false, 0, true);
			_http.addEventListener(FaultEvent.FAULT, onWebFault);
		}
		
		private function appendTimestampToUrl(url:String):String
		{
			//return url + "&" +
			//	"ts=" + new Date().getMilliseconds().toString(); 
			return url;
		}
		
		private function appendCredentialsToUrl(
			url:String, 
			tradingApiConnection:TradingAPIConnection):String
		{
			var userName:String = "";
			var Session:String = "";
			
			if ( tradingApiConnection != null )
			{
				if ( tradingApiConnection.authentication ) 
				{
					if ( tradingApiConnection.authentication.Username != null ) 
					{
						userName = tradingApiConnection.authentication.Username; 
					}

					if ( tradingApiConnection.authentication.Session != null ) 
					{
						Session = tradingApiConnection.authentication.Session; 
					}
					
				}
			}

			if (RequestHasParameters(url))
			{
				return url + "&UserName=" + userName + "&Session=" + Session;// + "&" +//"ClientAccountId=" + tradingApiConnection.ClientAccountId;
			}
			else
			{
				return url + "?UserName=" + userName + "&Session=" + Session;
			}
		}
		
		private function RequestHasParameters(url:String):Boolean
		{
			if (url.charAt(url.length) == "/") return false;
			
			if (url.substring(url.lastIndexOf("/"), url.length).indexOf("?") == -1) return false;
			
			return true;
		}
		
		public function BeginRequest(url:String):AsyncToken
		{
			_http.url = appendTimestampToUrl(url);
			
			if (_tradingAPIConnection != null)
			{
				_http.url = appendCredentialsToUrl(
					_http.url, 
					_tradingAPIConnection); 
			}
			_http.method = "GET";
			return _http.send();
		}
		
		public function BeginPost(url:String, data:Object):AsyncToken
		{
			_http.url = url;
			_http.method = "POST";
			_http.contentType = "application/json";
			var postData:ByteArray = new ByteArray();
			postData.writeUTFBytes(data.toString());
			postData.position = 0;
			return _http.send(postData);
		}
		
		public function CancelRequest():void
		{
			_http.cancel();
		}
		
		public function OnWebResponse(event:ResultEvent):void
		{
			dispatchEvent(new ResultEvent(WebClient.WEB_RESPONSE_EVENT,false,true,event.result));
		}		
		
		private function onWebFault(event:FaultEvent):void
		{
			trace( event.message.toString() );	 
		}
	}
}