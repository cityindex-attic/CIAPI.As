package TradingApi.Client.Core.Utilities
{
	public class Conversion
	{
		public static function DateFromJSONDateString(dateString:String):Date
		{
			// /Date(1271324700000+0100)/
			// /Date(1283866590890)/
			// \/Date(1284136483000)\/
			dateString = dateString.substring(dateString.indexOf("(") + 1, dateString.indexOf(")"));
			var arr:Array = dateString.split("+");
			var date:Date = new Date(Number(arr[0]));
			
			return date;
		}
		
		
		
		
		//2010-03-20T08:57:08.0131100Z0
		public static function isoToDate(value:String):Date 
		{
			var dateStr:String = value;
			var milliseconds : Number = Number( dateStr.match( /\.[0-9]+/ ) ) * 1000;
			
			dateStr = dateStr.replace(/(\d{4,4})\-(\d{2,2})\-(\d{2,2})/g, "$1/$2/$3"); //replace - with /
			dateStr = dateStr.replace("T", " "); //T => " "
			dateStr = dateStr.replace( /\.[0-9]+/, " " ); //drop the milliseconds
			dateStr = dateStr.replace(/(\+|\-)(\d+):(\d+)/g, " UTC$1$2$3"); //time offset from UTC
			dateStr = dateStr.replace("Z0", " UTC-0000"); //Z or Z0 = UTC-0000
			dateStr = dateStr.replace("Z", " UTC-0000");
			
			var date:Date = new Date( Date.parse( dateStr ) );
			date.setMilliseconds( milliseconds );
			return date;
			
		}    
	}
}