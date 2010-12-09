package TradingApi.Client.Core
{
	import flash.events.EventDispatcher;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	[Event(type="MarketFetcher_MarketFetcherResponseEvent", type="mx.rpc.events.ResultEvent")]
	public class MarketFetcher extends TradingAPIHelper
	{
		
		public static const MARKET_SEARCH_RESPONSE_EVENT:String = "MarketFetcher_MarketFetcherResponseEvent"; 
		
    	public function MarketFetcher(tradingAPIConnection:TradingAPIConnection)
		{
			super(tradingAPIConnection);
		}
		
		public function beginSearchMarkets(search:String,marketType:String="cfd", maxResults:int=25):void
		{
			
			var ClientAccountId:String = ""; 
			
			if ( TradingApiConnection != null ) 
			{
				if ( TradingApiConnection.authentication != null ) 
				{
					if ( TradingApiConnection.authentication.ClientAccountId != null )
					{
						ClientAccountId = TradingApiConnection.authentication.ClientAccountId;
					}
				}
			}
			
			if(marketType == "cfd")
			{
				Get("/cfd/markets?MarketName=" + search + 
					"&MaxResults=" + maxResults.toString() + 
					"&ClientAccountId=" + ClientAccountId );
			}
			else
			{
				Get("/spread/markets?MarketName=" + search + 
					"&MaxResults=" + maxResults.toString() + 
					"&ClientAccountId=" + ClientAccountId );
			}
			
		}
		
		public override function Response(data:Object):void
		{
			dispatchEvent(new ResultEvent(MARKET_SEARCH_RESPONSE_EVENT, false, true, data.Markets));
		}
		
	}
}


