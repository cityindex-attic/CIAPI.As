package TradingApi.Client.Core
{
	import TradingApi.Client.Core.MarketFetcher;
	import TradingApi.Client.Core.TradingAPIConnection;
	
	import flexunit.framework.Assert;
	
	import mx.rpc.events.ResultEvent;
	import org.flexunit.async.Async;
	
	public class MarketFetcherTests
	{		
	
		private var _baseUrl:String = "https://93.187.19.139/TradingAPI";
		private var _query:String = "uk";
		
		[Test(async, description="" )]
		public function SearchForMarketReturnsArrayOf20Markets():void 
		{
			var tradingApiConnection:TradingAPIConnection = new TradingAPIConnection(_baseUrl);
			tradingApiConnection.Authenticate("CC735158","password");
			
			var marketFetcher:MarketFetcher = new MarketFetcher(tradingApiConnection);
			
			marketFetcher.addEventListener(MarketFetcher.MARKET_SEARCH_RESPONSE_EVENT,
				Async.asyncHandler( this, handleMarketSearchResponse, 500, null, handleTimeout ),false,0,true);
			
			marketFetcher.beginSearchMarkets(_query,"cfd", 20);
		}
		
		private function handleMarketSearchResponse(event:ResultEvent, passThrough:Object):void
		{
			var marketListArray:Array = event.result as Array;
			Assert.assertEquals(20, marketListArray.length);
		}
		
		protected function handleTimeout( passThroughData:Object ):void 
		{
			//Assert.fail( "MarketFetcher.beginSearchMarkets didn't raise MarketFetcher.MARKET_SEARCH_RESPONSE_EVENT");			
		}
		
	}
	
}