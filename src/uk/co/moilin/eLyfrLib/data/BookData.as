package uk.co.moilin.eLyfrLib.data
{
	import mx.collections.ArrayCollection;

	public class BookData
	{
		private var _title:String;
		public function get title():String { return _title };

		private var _thumb:String;
		public function get thumb():String { return _thumb };

		private var _pages:Array;
		public function get pages():Array { return _pages };
		
		public function BookData(rawData:XML)
		{
			_title = rawData.title;
			_thumb = rawData.thumb;
			_pages = new Array();
			for each (var page:XML in rawData.pages.page)
			{
				pages.push(new PageData(page));
			}
		}
	}
}