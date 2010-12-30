package TradingApi.Client.Core
{
	import flash.events.Event;
	
	public class PriceHistoryResponseEvent extends Event
	{
		public var PriceHistoryBars:Array;
		
		public function PriceHistoryResponseEvent(type:String, priceHistoryBars:Array)
		{
			super(type);
			this.PriceHistoryBars = priceHistoryBars;
		}
		
		public override function clone():Event {
         	return new PriceHistoryResponseEvent(type, PriceHistoryBars);
        }

	}
}