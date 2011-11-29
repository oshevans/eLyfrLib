package uk.co.moilin.eLyfrLib.events
{
	import flash.events.Event;
	
	public class PageListEvent extends Event
	{
		public static const PAGE_CHANGE:String = "pageChange";
		
		public var newIndex:int;
		public var oldIndex:int;
		
		public function PageListEvent(type:String, bubbles:Boolean = false,
									  cancelable:Boolean = false,
									  oldIndex:int = -1,
									  newIndex:int = -1)
		{
			super(type, bubbles, cancelable);
			
			this.oldIndex = oldIndex;
			this.newIndex = newIndex;
		}
		
		override public function clone():Event
		{
			return new PageListEvent(type, bubbles, cancelable,
				oldIndex, newIndex);
		}
	}
}