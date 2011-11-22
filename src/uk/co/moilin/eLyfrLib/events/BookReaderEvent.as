package uk.co.moilin.eLyfrLib.events
{
	import flash.events.Event;
	
	public class BookReaderEvent extends Event
	{
		public static const ITEM_SELECTED:String = "item_selected"; 
		
		public var selectedBook:int;
		
		public function BookReaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, bookID:int=-1)
		{
			super(type, bubbles, cancelable);
			
			if(type == ITEM_SELECTED)
				selectedBook = bookID;
		}
	}
}