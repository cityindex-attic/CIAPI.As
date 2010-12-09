package TradingApi.Client.Core
{
	import mockDomain.PriceBuilder;
	
	import TradingApi.Client.Core.Domain.Price;
	import TradingApi.Client.Core.Lightstreamer.LightstreamerConnection;
	import TradingApi.Client.Core.PriceUpdateEvent;
	
	import com.lightstreamer.as_client.LSClient;
	import com.lightstreamer.as_client.NonVisualTable;
	
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.token.AsyncTestToken;
	
	public class PriceListenerTests
	{		
		private var _mockConnection:LightstreamerConnection;
			
		[Test (async, description="")]
		[Ignore()]
		public function PriceListenerResponseToLightStreamerEvent():void
		{
				var priceBuilder:PriceBuilder = new PriceBuilder();
				priceBuilder.MarketId = 12322211;
				
	            var expectedPrice:Price = priceBuilder.Build();
				
				var connection:LightstreamerConnection = new LightstreamerConnection("","","","","");
				
	            //Setup a PricingClient listening to a dummy market Id
	            var priceListenerClient:PriceListener = new PriceListener(expectedPrice.MarketId, connection);
	
				var c:LSClient = new LSClient();
				c["updateDataCommand"]("0,1||10.0101064086059|10.0101064086059|||669f190d-90ba-4209-b526-cc7802abf05e0||||");
	
	            //Trap the Price given by the update event for checking
				priceListenerClient.addEventListener(PriceListener.PRICE_UPDATE_EVENT,
					Async.asyncHandler( this, handlePriceUpdate, 500, expectedPrice, handleTimeout ),false,0,true);
				
				var table:NonVisualTable = priceListenerClient.GetNonVisualTable();
//				table.dispatchOnItemUpdate
//	
//				var streamingEvent:NonVisualItemUpdateEvent = new NonVisualItemUpdateEvent(
//					table,
	            
				//Trigger StreamingUpdateEvent using a mock streaming update
//				var builder:PriceBuilder = new PriceBuilder();
//	            var mockStreamingUpdate = builder.CreateMockStreamingUpdateForPrice(expectedPrice);
//	            pricingAdapterClient.OnUpdate(mockStreamingUpdate);
//	
//	            //Ensure the correct price was fetched from the Update
//	            mockStreamingUpdate.Item.Update.VerifyAllExpectations();
				Assert.assertEquals(1,1);
		}
		
		private function handlePriceUpdate(e:PriceUpdateEvent,passThroughData:Object):void
		{
			var expectedPrice:Price = passThroughData as Price;
			
			Assert.assertEquals(expectedPrice.toString(), e.Price.toString());
		}
		
		protected function handleTimeout( passThroughData:Object ):void {
			Assert.fail( "Timeout reached before event");			
		}
			
	}
}
