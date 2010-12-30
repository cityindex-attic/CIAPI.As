package TradingApi.Client.Core
{
	import TradingApi.Client.Core.Domain.PriceBar;
	import TradingApi.Client.Core.Domain.PriceHistoryRequest;
	
	import mx.rpc.events.ResultEvent;
	
	[Event(type="PriceHistoryFetcher_PriceHistoryResponseEvent", type="TradingApi.Client.Core.PriceHistoryResponseEvent")]
	public class PriceHistoryFetcher extends TradingAPIHelper
	{
		public static const PRICE_HISTORY_RESPONSE_EVENT:String = "PriceHistoryFetcher_PriceHistoryResponseEvent"; 
		
		public function PriceHistoryFetcher(tradingAPIConnection:TradingAPIConnection)
		{
			super(tradingAPIConnection);
		}
		
		public function BeginPriceHistoryRequest(historyRequest:PriceHistoryRequest):void
		{
			var request:String = historyRequest.Generate();
			Get(request);
		}
		
		public override function Response(data:Object):void
		{
			
			var untypedPriceHistoryBars:Array;
		
			if (data.PriceBars)
			{
				untypedPriceHistoryBars = data.PriceBars as Array; 
			}
			else
			{
				untypedPriceHistoryBars = data.PriceTicks as Array; 
			}
			var priceHistoryBars:Array = new Array();
			for (var i:uint = 0; i<untypedPriceHistoryBars.length; i++)
			{
				priceHistoryBars.push(PriceBar.ConvertFromObject(untypedPriceHistoryBars[i]));
			}
			
			if (data.PartialPriceBar)
				priceHistoryBars.push(PriceBar.ConvertFromObject(data.PartialPriceBar));
			
			dispatchEvent(new PriceHistoryResponseEvent(PriceHistoryFetcher.PRICE_HISTORY_RESPONSE_EVENT,priceHistoryBars));
		}
		
		// For now we dispatch an empty array, perhaps in the future we can inform consumer of what went wrong? -- Chase
		public override function Fault(info:Object):void
		{
			dispatchEvent(new PriceHistoryResponseEvent(PriceHistoryFetcher.PRICE_HISTORY_RESPONSE_EVENT, new Array()));
		}

	}
}