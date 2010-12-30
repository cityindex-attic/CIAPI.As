package TradingApi.Client.Core.Utilities
{
	public class Web
	{
		public static function StripTrailingSlash(url:String):String
		{
			if (url.lastIndexOf("/") == url.length-1)
			{
				url = url.substr(0, url.length-1);
			}
			return url;
		}
		
		// @Description: Converts strings like "2008-10-13-18-52"
		public static function fromRateDateString(rateDate:String):Date
		{
			var dateArray:Array;
			var date:Date = new Date();
			
			dateArray = rateDate.split("-");
			
			date.setFullYear(dateArray[0],
				Number(dateArray[1]) - 1,
				dateArray[2]);
			
			date.setHours(dateArray[3],
				dateArray[4], 0, 0);
			
			return date;
		}
	}
}