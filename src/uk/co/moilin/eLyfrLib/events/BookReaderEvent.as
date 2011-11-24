package uk.co.moilin.eLyfrLib.events
{
	import flash.events.Event;
	
	public class BookReaderEvent extends Event
	{
		public static const ITEM_SELECTED:String = "item_selected"; 
		public static const HOME_REQUEST:String = "home_request";
		public static const REPLAY_REQUEST:String = "replay_request";
		
		private var _selectedBook:int;
		public function get selectedBook():int { return _selectedBook };
		
		public function BookReaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, bookID:int=-1)
		{
			super(type, bubbles, cancelable);
			
			if(type == ITEM_SELECTED)
				_selectedBook = bookID;
		}
	}
}