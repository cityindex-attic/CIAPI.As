package TradingApi.Client.Core
{
	import TradingApi.Client.Core.Domain.LogonRequest;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class Authentication extends TradingAPIHelper
	{
		private var _session:String;
		public function get Session():String {return _session;}
		
		private var _username:String;
		public function get Username():String {return _username;}
		
		private var _clientAccountId:String;
		public function get ClientAccountId():String {return _clientAccountId;}
		
		public function Authentication(tradingAPIConnection:TradingAPIConnection)
		{
			super(tradingAPIConnection);
		}
		
		public function Authenticate(username:String, password:String):void
		{
			_username = username;
			
			var body:Object = new Object();
			body.UserName = username;
			body.Password = password;
			
			Post("/session", body);
		}
		
		public function logout(userName:String, session:String):void
		{
			var bodyRequest:Object = new Object();
			bodyRequest.UserName = userName;
			bodyRequest.Session = session;
			Post("/session?_method=DELETE", bodyRequest);
		}
		
		public override function Response(data:Object):void
		{
			_session = data.Session;
			
			// TODO: For now this is hardcoded; however, in the future it will be returned with our session: -- Chase
			_clientAccountId = "400059903";
			
			// if the user want to logout we dispatch an event 
			if( data.LoggedOut )
			{
				TradingApiConnection.dispatchEvent(new ResultEvent(TradingAPIConnection.LOGOUT_SUCCESS,false,true));
			}
			if (_session != "")
			{
				TradingApiConnection.dispatchEvent(new ResultEvent(TradingAPIConnection.AUTHENTICATION_SUCCESS,false,true,_session));
			}
			else
			{
				TradingApiConnection.dispatchEvent(new FaultEvent(TradingAPIConnection.AUTHENTICATION_FAILURE));
			}
		}
		
		public override function Fault(info:Object):void
		{
			TradingApiConnection.dispatchEvent(new FaultEvent(TradingAPIConnection.AUTHENTICATION_FAILURE));
		}
		
	}
}