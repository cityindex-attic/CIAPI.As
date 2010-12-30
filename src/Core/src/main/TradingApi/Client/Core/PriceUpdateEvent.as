package TradingApi.Client.Core
{
	
	import TradingApi.Client.Core.Domain.Price;
	
	import flash.events.Event;
	
	public class PriceUpdateEvent extends Event
	{
		public var Price:TradingApi.Client.Core.Domain.Price;
		
		public function PriceUpdateEvent(type:String, price:TradingApi.Client.Core.Domain.Price)
		{
			super(type);
			this.Price = price;
		}
		
		public override function clone():Event {
         	return new PriceUpdateEvent(type, Price);
        }

	}
}