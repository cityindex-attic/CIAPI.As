package TradingApi.Client.Core
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class TradingAPIHelper extends EventDispatcher implements IResponder
	{
		
		private var _tradingAPIConnection:TradingAPIConnection;
		public function get TradingApiConnection():TradingAPIConnection { return _tradingAPIConnection; }
		
		public function TradingAPIHelper(tradingAPIConnection:TradingAPIConnection)
		{
			_tradingAPIConnection = tradingAPIConnection;
		}
		
		/** Response and Fault will be overriden in classes that extend them.... */
		public function Response(data:Object):void
		{}
		
		public function Fault(info:Object):void
		{}
		
		private var _token:AsyncToken;
		
		public function Get(request:String):void
		{
			try{
				_token = _tradingAPIConnection.Get(request);
				_token.addResponder(this);
			} catch(e:Error)
			{
				trace(e.message);
			}
		}
		
		public function Post(request:String, body:Object):void
		{
			_token = _tradingAPIConnection.Post(request, body);
			_token.addResponder(this);
		}
		
		// Decode the response JSON and then call the overriden Response function....
		public function result(data:Object):void
		{
			trace(data);
			Response(JSON.decode(data.result.toString()));
		}
		
		public function fault(info:Object):void
		{
			trace(info);
			Fault(info);
		}
		
		
	}
}