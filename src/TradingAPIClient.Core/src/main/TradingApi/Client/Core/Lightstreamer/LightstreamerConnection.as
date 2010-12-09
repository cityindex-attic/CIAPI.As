package TradingApi.Client.Core.Lightstreamer
{
	import com.lightstreamer.as_client.ConnectionInfo;
	import com.lightstreamer.as_client.ConnectionPolicy;
	import com.lightstreamer.as_client.LSClient;
	import com.lightstreamer.as_client.events.ConnectionDropEvent;
	import com.lightstreamer.as_client.events.ControlConnectionErrorEvent;
	import com.lightstreamer.as_client.events.ServerErrorEvent;
	import com.lightstreamer.as_client.events.StatusChangeEvent;
	
	import flash.events.EventDispatcher;
	
	[Event(type="LightstreamerConnection_StatusChangedEvent", type="TradingApi.Client.Core.StatusChangedEvent")]
	public class LightstreamerConnection extends EventDispatcher
	{
		public static const STATUS_CHANGED_EVENT:String = "LightstreamerConnection_StatusChangedEvent"; 
		
		private var _serverUrl:String;
        private var _username:String;
        private var _password:String;
		private var _controlPort:String;
		private var _port:String;
        
		private var _isOpen:Boolean = false;
		public function get IsOpen():Boolean
		{
			return _isOpen;
		}
		
		private var _lsClient:com.lightstreamer.as_client.LSClient;
		public function get LSClient():com.lightstreamer.as_client.LSClient
		{
			if (_lsClient==null)
			{
				_lsClient = new com.lightstreamer.as_client.LSClient();
			}
			return _lsClient;
		}
		
		public function LightstreamerConnection(serverUrl:String, username:String, password:String , controlPort:String , port:String)
		{
			_serverUrl = serverUrl;
            _username = username;
            _password = password;
			_controlPort = controlPort;
			_port = port;
		}
		
		public function Open(adapterName:String = "CITYINDEXSTREAMING"):void
		{
			if (_isOpen) return;
			var cInfo:ConnectionInfo = new ConnectionInfo();
			cInfo.setServer(_serverUrl);
			//cInfo.setAdapter("CITYINDEXSTREAMING");
			cInfo.setAdapter(adapterName);
			cInfo.setControlPort( Math.abs(parseInt( _controlPort )) );
			cInfo.setPort( Math.abs(parseInt( _port )) );
			
			cInfo.setControlProtocol("https");		
			cInfo.setProtocol("https");
			cInfo.setUser(_username);
			cInfo.setPassword(_password);
			
			//the ConnectionInfo object represents the policy in use to interact with 
			//Lightstreamer Server				
			var cPolicy:ConnectionPolicy = new ConnectionPolicy();
			//cPolicy.setIdleTimeout(30000);
			//cPolicy.setKeepaliveInterval(0);
			//cPolicy.setPollingInterval(500);
			//cPolicy.setTimeoutForStalled(2000);
			//cPolicy.setTimeoutForReconnect(15000);
			
			LSClient.addEventListener(StatusChangeEvent.STATUS_CHANGE,onStatusChange);
			LSClient.addEventListener(ServerErrorEvent.SERVER_ERROR,onServerError);
			LSClient.addEventListener(ConnectionDropEvent.CONNECTION_DROP,onConnectionDrop);
			LSClient.addEventListener(ControlConnectionErrorEvent.CONTROL_CONNECTION_ERROR,onControlConnectionError);
				
			LSClient.openConnection(cInfo,cPolicy);

            _isOpen = true;	
		}
		
            
		public function Close():void
		{
			if (_isOpen) _lsClient.closeConnection();
			_isOpen = false;
		}
		
		private function onStatusChange(evt:StatusChangeEvent):void 
		{
			dispatchEvent(new StatusChangedEvent(STATUS_CHANGED_EVENT,evt.status));
		}
			
		private function onControlConnectionError(evt:ControlConnectionErrorEvent):void 
		{
			var error:String = evt.toString();
		}
		
		private function onConnectionDrop(evt:ConnectionDropEvent):void 
		{
			var error:String = evt.toString();			
		}

		private function onServerError(evt:ServerErrorEvent):void 
		{
			var error:String = evt.toString();			
		}
		

	}
}