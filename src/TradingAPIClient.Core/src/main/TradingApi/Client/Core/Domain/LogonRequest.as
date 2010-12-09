package TradingApi.Client.Core.Domain
{
	public class LogonRequest
	{
		public var UserName:String;
		public var Password:String;
		
		public function LogonRequest(username:String, password:String)
		{
			UserName = username;
			Password = password;
		}
		
		public function toString():String
		{
			return "LogonRequest: Username="+UserName+", Password="+Password;
		}
	}
}