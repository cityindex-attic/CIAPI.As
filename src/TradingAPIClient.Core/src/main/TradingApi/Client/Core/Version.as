package TradingApi.Client.Core
{
	public class Version
	{
		//!!VersionNumbersBEGIN
		private static var _buildNumber:String = "0.51-SNAPSHOT";
		//!!VersionNumbersEND
		
		public function Version()
		{
		}
		
		public static function get formatted():String
		{
			return "TradingApiClient.Core: " + _buildNumber;
		}
	}
}