package TradingApi.Client.Core.news
{
	import TradingApi.Client.Core.TradingAPIConnection;
	import TradingApi.Client.Core.TradingAPIHelper;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	[Event(type="NewsFetcher_NewsFetcherResponseEvent", type="mx.rpc.events.ResultEvent")]
	public class NewsFetcher extends TradingAPIHelper
	{
		
		public static const NEWS_SEARCH_RESPONSE_EVENT:String = "NewsFetcher_MarketFetcherResponseEvent"; 
		
    	public function NewsFetcher(tradingAPIConnection:TradingAPIConnection)
		{
			super(tradingAPIConnection);
		}
		
		public function searchNews(category:String, maxResults:int):void
		{
			
			/*var ClientAccountId:String = ""; 
			
			if ( TradingApiConnection != null ) 
			{
				if ( TradingApiConnection.authentication != null ) 
				{
					if ( TradingApiConnection.authentication.ClientAccountId != null )
					{
						ClientAccountId = TradingApiConnection.authentication.ClientAccountId;
					}
				}
			}*/
			
			Get("/cfd/news?Category=" + category+ 
				"&MaxResults=" + maxResults.toString() );
			//+ "&ClientAccountId=" + ClientAccountId 
		}
		
		public override function Response(data:Object):void
		{
			dispatchEvent(new ResultEvent(NEWS_SEARCH_RESPONSE_EVENT, false, true, data.Headlines));
		}
		
	}
}


