package TradingApi.Client.Core.Domain
{
	public class PriceHistoryRequest
	{
		public function PriceHistoryRequest(){}
		
		private var _requestType:String;
		
		private var _interval:String;
		public function get Interval():String { return _interval; }
		public function set Interval(value:String):void
		{
			_interval = value;
			if (_interval.toLowerCase() != "tick")
			{
				_requestType = "barhistory";
			}
			else
			{
				_requestType = "tickhistory";
			}
		}
		
		public var MarketId:int;
        public var Span:int;
        public var MaxNumberOfBars:int;
        public var NumberOfBars:int;
        public var StartDate:Date;
        public var EndDate:Date;
		
		public function Generate():String
		{
			var request:String;
			
			request = "/market/"
				+ MarketId.toString() + "/" 
				+ _requestType;
			
			if (_requestType == "barhistory")
			{
				request += "?interval=" + Interval.toString()
				+ "&span=" + Span.toString()
				+ "&pricebars=" + MaxNumberOfBars.toString(); 
			}
			else
			{
				request += "?priceticks=" + MaxNumberOfBars.toString(); 
			}
			
			return request;
		}
		
	}
}