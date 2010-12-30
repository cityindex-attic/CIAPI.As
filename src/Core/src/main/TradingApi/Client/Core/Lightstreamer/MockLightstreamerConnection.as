package TradingApi.Client.Core.Lightstreamer
{
	import com.lightstreamer.as_client.LSClient;
	import com.lightstreamer.as_client.Table;

	public class MockLightstreamerConnection extends LightstreamerConnection
	{
		
		private var _LSClient:MockLSClient;
		
		public function MockLightstreamerConnection(serverUrl:String, username:String, password:String , controlPort:String , port:String)
		{
			super(serverUrl, username, password, controlPort, port);
			_LSClient = new MockLSClient();
		}
		
		public override function get LSClient():com.lightstreamer.as_client.LSClient
		{
			return _LSClient;
		}
	}
}