package TradingApi.Client.Core.Domain
{
	import TradingApi.Client.Core.Utilities.Conversion;
	
	public class PriceBar
	{
		public function PriceBar(){}
		
		public var BarDate:Date;
        public var Open:Number;
        public var High:Number;
        public var Low:Number;
        public var Close:Number;
        public var Volume:Number;
        public var OpenInterest:Number;
        
        public function toString():String {  
		   return "PriceBar: BarDate={0}," +
                  "Open="+Open+",High="+High+",Low="+Low+",Close="+Close+"," +
                  "Volume="+Volume+",OpenInterest="+OpenInterest;  
		}  
		
		public static function ConvertFromObject(obj:Object):PriceBar
		{
			var p:PriceBar = new PriceBar();
			p.BarDate = Conversion.DateFromJSONDateString(obj.BarDate);
			p.Open = obj.Open;
			p.High = obj.High;
			p.Low = obj.Low;
			p.Close = obj.Close;
			p.Volume = obj.Volume;
			p.OpenInterest = obj.OpenInterest;
			
			return p;
		}
	}
}