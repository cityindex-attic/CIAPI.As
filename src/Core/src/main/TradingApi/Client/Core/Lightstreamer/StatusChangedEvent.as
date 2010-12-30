package TradingApi.Client.Core.Lightstreamer
{
	import flash.events.Event;
	
	public class StatusChangedEvent extends Event
	{
		public var Status:String;
		
		public function StatusChangedEvent(type:String, status:String)
		{
			super(type);
			this.Status = status;
		}
		
		public override function clone():Event {
         	return new StatusChangedEvent(type, Status);
        }
	}
}