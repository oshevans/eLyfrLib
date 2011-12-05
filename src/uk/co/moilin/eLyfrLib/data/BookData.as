package uk.co.moilin.eLyfrLib.data
{
	import flash.display.StageAspectRatio;
	
	import mx.collections.ArrayCollection;

	public class BookData
	{
		public static const NAV_MODE_BUTTONS:String = "buttons";
		public static const NAV_MODE_SWIPE:String = "swipe";
		
		private var _title:String;
		public function get title():String { return _title };
		
		private var _aspectRatio:String;
		public function get aspectRatio():String { return _aspectRatio };
		
		private var _navMode:String;
		public function get navMode():String { return _navMode };

		private var _thumb:String;
		public function get thumb():String { return _thumb };

		private var _pages:Array;
		public function get pages():Array { return _pages };
		
		public function BookData(rawData:XML)
		{
			_title = rawData.title;
			_aspectRatio = getAspectRatio(rawData.@aspectRatio);
			_navMode = getNavMode(rawData.@navMode);
			_thumb = rawData.thumb;
			_pages = new Array();
			for each (var page:XML in rawData.pages.page)
			{
				pages.push(new PageData(page));
			}
		}
		
		/**
		 * Determins required aspecRatio for book 
		 * @param aspect requested aspect from config data
		 * @return 'landscape', 'portrait' or 'auto'(default)
		 * 
		 */
		private function getAspectRatio(aspect:String):String
		{
			if(aspect == StageAspectRatio.LANDSCAPE || aspect == StageAspectRatio.PORTRAIT)
				return aspect;
			else
				return "auto";
		}
		
		/**
		 * Determins required navMode for book 
		 * @param mode requested navMode from config data
		 * @return 'buttons' or 'swipe'(default)
		 * 
		 */
		private function getNavMode(mode:String):String
		{
			if(mode == BookData.NAV_MODE_BUTTONS)
				return BookData.NAV_MODE_BUTTONS;
			else
				return BookData.NAV_MODE_SWIPE;
		}
		
	}
}