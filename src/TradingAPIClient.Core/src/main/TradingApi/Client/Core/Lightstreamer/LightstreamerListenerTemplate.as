package TradingApi.Client.Core.Lightstreamer
{
	import com.lightstreamer.as_client.NonVisualTable;
	import com.lightstreamer.as_client.events.EndOfSnapshotEvent;
	import com.lightstreamer.as_client.events.LostUpdatesEvent;
	import com.lightstreamer.as_client.events.NonVisualItemUpdateEvent;
	import com.lightstreamer.as_client.events.SubscriptionErrorEvent;
	import com.lightstreamer.as_client.events.UnsubscriptionEvent;
	
	import flash.events.EventDispatcher;
	
	public class LightstreamerListenerTemplate extends EventDispatcher
	{
		protected var _connection:LightstreamerConnection;
		
		protected var _nonVisualTable:NonVisualTable;
		
		public function LightstreamerListenerTemplate(connection:LightstreamerConnection)
		{
			_connection = connection;	
		}
		
		public function Subscribe(adapterName:String = "CITYINDEXSTREAMING"):void
		{
			_connection.Open(adapterName);
			
			_nonVisualTable = GetNonVisualTable();
			_nonVisualTable.setSnapshotRequired(true);

			_nonVisualTable.addEventListener(SubscriptionErrorEvent.SUBSCRIPTION_ERROR,onSubscriptionError);
			_nonVisualTable.addEventListener(EndOfSnapshotEvent.END_OF_SNAPSHOT,onEOS);
			_nonVisualTable.addEventListener(LostUpdatesEvent.LOST_UPDATES,onLost);
			_nonVisualTable.addEventListener(UnsubscriptionEvent.UNSUBSCRIPTION,onUnsub);
			_nonVisualTable.addEventListener(NonVisualItemUpdateEvent.NON_VISUAL_ITEM_UPDATE,onChange);
			//subscribe the table
			_connection.LSClient.subscribeTable(_nonVisualTable);
		}
		
		public function UnSubscribe(adapterName:String = "CITYINDEXSTREAMING"):void
		{
			_nonVisualTable.removeEventListener(SubscriptionErrorEvent.SUBSCRIPTION_ERROR,onSubscriptionError);
			_nonVisualTable.removeEventListener(EndOfSnapshotEvent.END_OF_SNAPSHOT,onEOS);
			_nonVisualTable.removeEventListener(LostUpdatesEvent.LOST_UPDATES,onLost);
			_nonVisualTable.removeEventListener(UnsubscriptionEvent.UNSUBSCRIPTION,onUnsub);
			_nonVisualTable.removeEventListener(NonVisualItemUpdateEvent.NON_VISUAL_ITEM_UPDATE,onChange);
			
			_connection.LSClient.unsubscribeTable(_nonVisualTable);
		}
		
		public function GetNonVisualTable():NonVisualTable
		{ 
			throw new Error("this should be overridden");
		}
		
		public function onChange(evt:NonVisualItemUpdateEvent):void 
		{
			throw new Error("this should be overridden");
		}		
		
		public function onSubscriptionError(evt:SubscriptionErrorEvent):void 
		{
			trace("subscription error");
		}

		public function onEOS(evt:EndOfSnapshotEvent):void 
		{
			trace("lightStreamerListenerTemplate->onEOS error");
		}
		
		public function onLost(evt:LostUpdatesEvent):void 
		{
			trace("lightStreamerListenerTemplate->onLOST error");
		}
		
		public function onUnsub(evt:UnsubscriptionEvent):void 
		{
		}
	}
}