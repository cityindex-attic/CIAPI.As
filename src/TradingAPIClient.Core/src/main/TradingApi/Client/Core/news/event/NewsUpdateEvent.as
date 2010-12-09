package TradingApi.Client.Core.news.event
{
	import TradingApi.Client.Core.Domain.NewVO;
	
	import flash.events.Event;
	
	public class NewsUpdateEvent extends Event
	{
		public static const NEW_UPDATE_EVENT:String = "newsUpdateEvent";
		public var updateNew:NewVO;
		
		public function NewsUpdateEvent(updated: NewVO)
		{
			this.updateNew = updated;
			super(NEW_UPDATE_EVENT);
		}
	}
}