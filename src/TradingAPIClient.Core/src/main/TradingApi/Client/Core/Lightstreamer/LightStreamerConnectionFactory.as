package TradingApi.Client.Core.Lightstreamer
{
	
	import mx.core.FlexGlobals;
	
	public class LightStreamerConnectionFactory
	{
		public static function Create(serverUrl:String, username:String, password:String , controlPort:String , port:String):LightstreamerConnection
		{
			var url:String = FlexGlobals.topLevelApplication.url;
			
			return new LightstreamerConnection(serverUrl, username, password , controlPort , port);
			
		}
	}
}