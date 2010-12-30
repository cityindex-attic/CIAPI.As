package TradingApi.Client.Core
{
	import TradingApi.Client.Core.Domain.Price;
	import TradingApi.Client.Core.Lightstreamer.LightstreamerConnection;
	import TradingApi.Client.Core.Lightstreamer.LightstreamerListenerTemplate;
	import TradingApi.Client.Core.Utilities.Conversion;
	
	import com.lightstreamer.as_client.NonVisualTable;
	import com.lightstreamer.as_client.events.NonVisualItemUpdateEvent;
	
	[Event(type="PriceListener_PriceUpdateEvent", type="TradingApi.Client.Core.PriceUpdateEvent")]
	public class PriceListener extends LightstreamerListenerTemplate
	{
		public static const PRICE_UPDATE_EVENT:String = "PriceListener_PriceUpdateEvent"; 

		private var _marketId:Number;
		public function PriceListener(marketId:Number, connection:LightstreamerConnection)
		{
			super(connection);
			_marketId = marketId;
		}

		public override function GetNonVisualTable():NonVisualTable
		{ 
//			var items:Array = new Array( String( "MOCKPRICE.1000"));
			var items:Array = new Array( String( "PRICE." + _marketId ) );
			//var items:Array = new Array( String( "MOCKPRICE." + _marketId ) );
			var fields:Array = new Array("MarketId","TickDate","Price", "Bid", "Offer","Direction","Change");
			
			var table:NonVisualTable = new NonVisualTable(items,fields,"MERGE");
			table.setDataAdapter("PRICES");
				
			return table;
		}

		public override function onChange(evt:NonVisualItemUpdateEvent):void 
		{
			var marketIdStr:String = getLatestValue(evt,"MarketId");
			if (marketIdStr!=null)
			{
				var newPrice:Price = new Price();
				newPrice.MarketId = int(Number(marketIdStr));
				newPrice.TickDate = Conversion.DateFromJSONDateString(getLatestValue(evt,"TickDate"));
				newPrice.PriceValue = Number(getLatestValue(evt,"Price"));
				newPrice.Bid = Number(getLatestValue(evt,"Bid"));
				newPrice.Offer = Number(getLatestValue(evt,"Offer"));
				newPrice.Direction = Number(getLatestValue(evt,"Direction"));
				newPrice.Change = Number(getLatestValue(evt,"Change"));
				
				dispatchEvent(new PriceUpdateEvent(PRICE_UPDATE_EVENT,newPrice));
			}
		}
		
		private function getLatestValue(evt:NonVisualItemUpdateEvent, field:String):String
		{
			if (evt.isFieldChanged(field))
				return evt.getFieldValue(field);

			return evt.getOldFieldValue(field);
		}		
		
		     
	}
}