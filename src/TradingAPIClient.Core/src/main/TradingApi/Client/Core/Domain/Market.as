package TradingApi.Client.Core.Domain
{
	public class Market
	{
		public var MarketId:int;
        public var Name:String;
		public var Precision:int;
        
        public function Market(marketId:int, name:String, precision:int)
        {
        	MarketId = marketId;
        	Name = name;
			Precision = precision;
        }
        
        public function toString():String {  
		   return "Market: Id="+MarketId+",Name="+Name;  
		}  
	}
}