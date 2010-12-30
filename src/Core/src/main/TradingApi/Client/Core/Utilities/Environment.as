package TradingApi.Client.Core.Utilities
{
	
	import flash.system.Capabilities;
	
	public class Environment
	{
		public static function SupportsHttpHeaderAuthentication():Boolean
		{
			var flashPlayerVersion:String = Capabilities.version;
			
			var osArray:Array = flashPlayerVersion.split(' ');
			var osType:String = osArray[0]; //The operating system: WIN, MAC, LNX
			var versionArray:Array = osArray[1].split(',');//The player versions. 9,0,115,0
			var majorVersion:Number = parseInt(versionArray[0]);
			var majorRevision:Number = parseInt(versionArray[1]);
			var minorVersion:Number = parseInt(versionArray[2]);
			var minorRevision:Number = parseInt(versionArray[3]);
			
			
			// If we are on version 9.0.115.0 or below, http auth is not supported
			// See this technote:
			//
			// "Authorization header does not work for an HTTP request (Flash Player)"
			// http://kb2.adobe.com/cps/403/kb403184.html
			if (majorVersion < 10)
			{
				if (minorVersion <= 115)
					return false;
			}
			
			return true;
		}
	}
}