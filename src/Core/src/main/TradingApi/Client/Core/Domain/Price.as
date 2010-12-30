package TradingApi.Client.Core.Domain
{
	public class Price
	{
		public var MarketId:int;
        public var TickDate:Date;
		public var PriceValue:Number;
		public var Bid:Number;
		public var Offer:Number;
		public var Direction:Number;
		public var Change:Number;
        
		public function Price(){}
		
        public function toString():String {  
		   return "Price: MarketId="+MarketId+",Bid="+Bid+",Offer="+Offer+",Direction="+Direction+","+
			   "Change="+Change+",TickDate="+TickDate+",Price="+PriceValue;  
		}  

	}
}