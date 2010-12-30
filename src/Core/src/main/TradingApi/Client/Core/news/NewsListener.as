package TradingApi.Client.Core.news
{
	import TradingApi.Client.Core.Domain.NewVO;
	import TradingApi.Client.Core.Domain.Price;
	import TradingApi.Client.Core.Lightstreamer.LightstreamerConnection;
	import TradingApi.Client.Core.Lightstreamer.LightstreamerListenerTemplate;
	import TradingApi.Client.Core.PriceUpdateEvent;
	import TradingApi.Client.Core.Utilities.Conversion;
	import TradingApi.Client.Core.news.event.NewsUpdateEvent;
	
	import com.lightstreamer.as_client.NonVisualTable;
	import com.lightstreamer.as_client.events.NonVisualItemUpdateEvent;
	
	import mx.rpc.events.HeaderEvent;
	
	[Event(type="NewsListener_NewsUpdateEvent", type="TradingApi.Client.Core.news.event.NewsUpdateEvent")]
	public class NewsListener extends LightstreamerListenerTemplate
	{
		public static const NEWS_UPDATE_EVENT:String = "NewsListener_NewsUpdateEvent"; 

		private var _regionId:String;
		private var newVO:NewVO;
		public function NewsListener(regionId:String, connection:LightstreamerConnection)
		{
			super(connection);
			_regionId = regionId;
		}

		public override function GetNonVisualTable():NonVisualTable
		{ 
//			var items:Array = new Array( String( "MOCKHEADLINES." +  _regionId ) );
			var items:Array = new Array( String( "HEADLINES." +  _regionId ) );
			var fields:Array = new Array("StoryId","Headline","PublishDate");
			
			var table:NonVisualTable = new NonVisualTable(items,fields,"RAW");
			table.setDataAdapter("NEWS");
				
			return table;
		}

		public override function onChange(evt:NonVisualItemUpdateEvent):void 
		{
			var storyIdStr:String = getLatestValue(evt,"StoryId");
			if (storyIdStr!=null)
			{
				newVO = new NewVO();
				newVO.storyId= int(Number(storyIdStr));
				newVO.publishDate = Conversion.DateFromJSONDateString(getLatestValue(evt,"PublishDate"));
				newVO.headLine = getLatestValue(evt,"Headline");

				dispatchEvent(new NewsUpdateEvent(newVO));
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