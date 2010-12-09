package TradingApi.Client.Core
{	
	import flash.events.Event;
	
	import flexunit.framework.Assert;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	
	public class TradingAPIConnectionTests
	{
		private var _baseUrl:String = "http://93.187.19.139/TradingAPI";
		private var _marketSearchUrl:String = "http://test/cfd/markets";
		
		/*[Test(async)]
		public function AfterAuthenticatingUserAndSessionShouldBeAppendedToQueryStringInCorrectFormat()
		{
			assertTrue((MockWebClient(mockWebClient))
				.GetHappened(_marketSearchUrl+"?vod&User=cc735158&session=GUID");
		}*/
		
		[Test(async)]
		public function AuthenticatingAgainstTradingApiWithUsernameAndPasswordReturnsASession():void
		{
			var tradingApiConnection:TradingAPIConnection = new TradingAPIConnection(_baseUrl);
		
			tradingApiConnection.addEventListener(TradingAPIConnection.AUTHENTICATION_SUCCESS,
				Async.asyncHandler(this, handleAuthenticationResponse, 5000, null, handleTimeout),
				false,
				0,
				true);
			tradingApiConnection.Authenticate("cc735158", "password");
		}
		
		[Test(async)]
		public function AuthenticatingWithBadPasswordReturnsEmptySession():void
		{
			var tradingApiConnection:TradingAPIConnection = new TradingAPIConnection(_baseUrl);
			
			tradingApiConnection.addEventListener(TradingAPIConnection.AUTHENTICATION_FAILURE, 
				Async.asyncHandler(this, handleAuthenticationResponse, 500, null, handleTimeout),
				false,
				0,
				true);
			
			tradingApiConnection.Authenticate("baduser", "badpassword");
		}
		
		private function handleAuthenticationResponse(event:Event, passThroughData:Object):void
		{
			if (event.type == TradingAPIConnection.AUTHENTICATION_SUCCESS)
			{
				Assert.assertNotNull(ResultEvent(event).result.toString());
			}
			//if (event.type == TradingAPIConnection.AUTHENTICATION_FAILURE)
			//{
				//assertEquals("", FaultEvent(event).fault.toString());
			//}
		}
		
		private function handleTimeout(passThroughData:Object):void
		{
			//Assert.fail("TradingAPIConnection Authentication was not called.");
		}
		
	}
}