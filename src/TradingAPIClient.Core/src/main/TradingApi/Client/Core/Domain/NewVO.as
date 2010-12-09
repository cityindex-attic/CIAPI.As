package TradingApi.Client.Core.Domain
{
	import TradingApi.Client.Core.Utilities.Conversion;

	public class NewVO
	{
		public var storyId:Number;
		public var headLine:String;
		public var publishDate:Date;
		public var story:String;
		
		
		public function NewVO( rawObject:Object = null)
		{
			if(rawObject)
			{
				this.storyId = rawObject.StoryId;
				this.headLine = rawObject.Headline;
				this.story = rawObject.Story;
				this.publishDate =  Conversion.DateFromJSONDateString(rawObject.PublishDate);
			}
		}
	}
}