package TradingApi.Client.Core.Lightstreamer
{
	import com.lightstreamer.as_client.LSClient;
	import com.lightstreamer.as_client.NonVisualTable;
	import com.lightstreamer.as_client.Table;
	import com.lightstreamer.as_client.events.NonVisualItemUpdateEvent;
	import com.lightstreamer.as_client.events.TableItemEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class MockLSClient extends LSClient
	{
		
		private var _eventTable:NonVisualTable;
		private var _timer:Timer;
		private var _completeValues:Array;
		
		public function MockLSClient()
		{
			// All values need to be strings for internal lightstreamer stuff to work:
			_completeValues = new Array("100","1.5","1.4","0","0.1","100","0.1","0","0");
			
			_timer = new Timer(5000);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		public override function subscribeTable(arg0:Table):void
		{
			// Add table to list of simulated broadcast targets, convert to NonVisualTable to we have access
			// to the underlying event dispatcher:
			_eventTable = arg0 as NonVisualTable;
			_timer.start();
		}
		
		public override function unsubscribeTable(arg0:Table):void
		{
			_timer.stop();
		}
		
		private function onTimer(event:TimerEvent):void
		{
			// NonVisualItemUpdateEvent(table, "itemId", "values", "completeValues", length, "schema", "keyId");
			// Schema needs to be an object with fieldnames and index values
			_eventTable.dispatchEvent(new NonVisualItemUpdateEvent(_eventTable, 
														"itemId", 
														new Array("100", randRange(1, 10).toString(), randRange(1, 10).toString(), "0", "0.1", "100", "0.1", "0", "0"), 
														_completeValues, 
														9, 
														{MarketId:0,Bid:1,Offer:2,Direction:3,Change:4,AuditId:5,Delta:6,Implied_Volatility:7,Indicative:8}));
		}
		
		private function randRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.random() * (maxNum - minNum + 1)) + minNum;
		}
		
	}
}