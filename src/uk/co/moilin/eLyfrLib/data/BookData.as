package uk.co.moilin.eLyfrLib.data
{
	import mx.collections.ArrayCollection;

	public class BookData
	{
		[Bindable]
		public var title:String;
		[Bindable]
		public var thumb:String;
		public var pages:Array;
		
		public function BookData(rawData:XML)
		{
			title = rawData.title;
			thumb = rawData.thumb;
			pages = new Array();
			for each (var page:XML in rawData.pages.page)
			{
				pages.push(new PageData(page));
			}
		}
	}
}