package TradingApi.Client.Core.news
{
	import TradingApi.Client.Core.TradingAPIConnection;
	import TradingApi.Client.Core.TradingAPIHelper;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	[Event(type="NewsDetailFetcher_NewsDetailFetcherResponseEvent", type="mx.rpc.events.ResultEvent")]
	public class NewsDetailFetcher extends TradingAPIHelper
	{
		
		public static const NEWS_DETAIL_RESPONSE_EVENT:String = "NewsDetailFetcher_NewsDetailFetcherResponseEvent"; 
		
    	public function NewsDetailFetcher(tradingAPIConnection:TradingAPIConnection)
		{
			super(tradingAPIConnection);
		}
		
		public function getDetail(storyId:Number):void
		{
			
			Get("/cfd/news/" + storyId );
		}
		
		public override function Response(data:Object):void
		{
			dispatchEvent(new ResultEvent(NEWS_DETAIL_RESPONSE_EVENT, false, true, data.NewsDetail));
		}
		
	}
}


