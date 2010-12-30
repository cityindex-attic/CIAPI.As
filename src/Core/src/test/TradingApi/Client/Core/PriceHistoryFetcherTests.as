package TradingApi.Client.Core
{
	import TradingApi.Client.Core.Domain.PriceHistoryRequest;
	import TradingApi.Client.Core.PriceHistoryFetcher;
	import TradingApi.Client.Core.PriceHistoryResponseEvent;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	public class PriceHistoryFetcherTests
	{	
		
		private var _baseUrl:String = "http://93.187.19.139/TradingAPI";

		
		[Test(async, description="" )]
		public function FetchPriceHistoryReturnsCollectionOfPriceBars():void 
		{
			var tradingApiConnection:TradingAPIConnection = new TradingAPIConnection(_baseUrl);
			tradingApiConnection.Authenticate("CC735158","password");
			
			//var marketFetcher:MarketFetcher = new MarketFetcher(tradingApiConnection);
			
			//marketFetcher.addEventListener(MarketFetcher.MARKET_SEARCH_RESPONSE_EVENT,
			//Async.asyncHandler( this, handleMarketSearchResponse, 500, null, handleTimeout ),false,0,true);
			
			//marketFetcher.beginSearchMarkets(_query, 20);
		}
		
		/*		
		[Test(async, description="Ensures the fetching price history call the appropriate url and parses the returned data correctly" )]
		public function FetchPriceHistoryReturnsCollectionOfPriceBars():void 
		{
			var historyRequest:PriceHistoryRequest = new PriceHistoryRequest();
			historyRequest.MarketId = -100;
			historyRequest.Interval = "day";
			historyRequest.Span = 0;
			historyRequest.MaxNumberOfBars = 5;
			
			var expectedUrl:String = _baseUrl + "/market/-100/history?interval=day&span=0&pricebars=5";
			
			var expectedResponseData:String =        
				'{"PriceBars": [{"Close":5.8780259404477695,"BarDate":"\/Date(1271321760000+0100)\/","High":6.1780259404477693,"Low":5.6780259404477693,"Open":5.9780259404477691,"OpenInterest":0,"Volume":0},'
				+'{"Close":4.0005883923309655,"BarDate":"\/Date(1271321820000+0100)\/","High":5.8780259404477695,"Low":3.8005883923309653,"Open":5.8780259404477695,"OpenInterest":0,"Volume":0},'
				+'{"Close":5.0012587753781563,"BarDate":"\/Date(1271321880000+0100)\/","High":5.3012587753781562,"Low":4.0005883923309655,"Open":4.0005883923309655,"OpenInterest":124,"Volume":847},'
				+'{"Close":5.9993220904718516,"BarDate":"\/Date(1271321940000+0100)\/","High":6.2993220904718514,"Low":5.0012587753781563,"Open":5.0012587753781563,"OpenInterest":0,"Volume":0},'
				+'{"Close":4.9276749214717457,"BarDate":"\/Date(1271322000000+0100)\/","High":5.9993220904718516,"Low":4.7276749214717455,"Open":5.9993220904718516,"OpenInterest":0,"Volume":0}]}';
			
			var tradingApiConnection:TradingAPIConnection = new TradingAPIConnection(_baseUrl);
			
			var priceHistoryFetcher:PriceHistoryFetcher = new PriceHistoryFetcher(tradingApiConnection);
			
			priceHistoryFetcher.addEventListener(PriceHistoryFetcher.PRICE_HISTORY_RESPONSE_EVENT,
				Async.asyncHandler( this, handlePriceHistoryResponse, 500, expectedUrl, handleTimeout ),false,0,true);
			
			priceHistoryFetcher.BeginPriceHistoryRequest(historyRequest);
		}
		
		private function handlePriceHistoryResponse(e:PriceHistoryResponseEvent,passThroughData:Object):void
		{
			Assert.assertEquals(5, e.PriceHistoryBars.length);
			Assert.assertEquals(4.0005883923309655, e.PriceHistoryBars[2].Open);
			Assert.assertEquals(5.3012587753781562, e.PriceHistoryBars[2].High);
			Assert.assertEquals(4.0005883923309655, e.PriceHistoryBars[2].Low);
			Assert.assertEquals(5.0012587753781563, e.PriceHistoryBars[2].Close);
			Assert.assertEquals(847, e.PriceHistoryBars[2].Volume);
			Assert.assertEquals(124, e.PriceHistoryBars[2].OpenInterest);
		}
		
		protected function handleTimeout( passThroughData:Object ):void {
			Assert.fail( "expectedUrl not called: "+ passThroughData);			
		}
		
		/*
		[Test()]
		public function AddTrailingSlashAddsSlashWhenMissing():void 
		{
			var url:String = "http://myserver.com/History";
			
			Assert.assertEquals(url + "/", new PriceHistoryFetcher("", TradingAPIConnection.create()).AddTrailingSlash(url));
		}
		
		[Test()]
		public function AddTrailingSlashDoesntAddsSlashWhenPresent():void 
		{
			var url:String = "http://myserver.com/History/";
			
			Assert.assertEquals(url, new PriceHistoryFetcher("", TradingAPIConnection.create()).AddTrailingSlash(url));
		}
		*/
	}
}