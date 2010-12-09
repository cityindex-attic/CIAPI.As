package TradingApi.Client.Core
{
	import TradingApi.Client.Core.Domain.*;
	import TradingApi.Client.Core.Utilities.Environment;
	import TradingApi.Client.Core.Utilities.Web;
	import TradingApi.Client.Core.WebClient.WebClient;
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.Base64Encoder;
	
	[Event(type="Authentication_Success", type="mx.rpc.events.ResultEvent")]
	[Event(type="Authentication_Failure", type="mx.rpc.events.FaultEvent")]
	[Event(type="TradingApiResponse", type="mx.rpc.events.ResultEvent")]
	[Event(type="logout_Success", type="mx.rpc.events.ResultEvent")]
	public class TradingAPIConnection extends EventDispatcher
	{		
		public static const AUTHENTICATION_SUCCESS:String = "Authentication_Success"; 
		public static const AUTHENTICATION_FAILURE:String = "Authentication_Failure";
		public static const LOGOUT_SUCCESS:String 		  = "logout_Success"; 
		public static const RESPONSE:String = "TradingApiResponse";
		
		private var _webClient:WebClient;
		public function get webClient():WebClient {return _webClient;}
		
		private var _authentication:Authentication;
		public function get authentication():Authentication {return _authentication;}
		
		private var _authToken:AsyncToken;
		private var _baseUrl:String;
		
		public function TradingAPIConnection(baseUrl:String)
		{	
			_baseUrl = Web.StripTrailingSlash(baseUrl);
			_webClient = new WebClient(this);
		}

		public function Authenticate(username:String, password:String):void
		{
			_authentication = new Authentication(this);
			_authentication.Authenticate(username, password);
		}
		
		/**
		 *Logout method  
		 * @param userName the username actually logged in
		 * @param session getted on successful login
		 * 
		 */
		public function logout(userName:String, session:String):void
		{
			_authentication = new Authentication(this);
			_authentication.logout(userName, session);
		}
		
		/*************
			GET and POST are two functions that will typically be called by helper classes extending TradingAPIHelper; however, they
			can be called directly. In this way, we can update the API server side without having to constantly release client updates.
			Clients can call get/post directly and write thier own code to handle the result. (Per conversation with Mike) -- Chase
		**************/
		public function Get(request:String):AsyncToken
		{
			return _webClient.BeginRequest(_baseUrl + request);
		}
		
		public function Post(request:String, body:Object):AsyncToken
		{
			return _webClient.BeginPost(_baseUrl + request, JSON.encode(body));
		}
		
	}
}