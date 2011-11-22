package uk.co.moilin.eLyfrLib.data
{
	public class PageSpreadData
	{
		public var isSingle:Boolean;
		public var page1:PageData;
		public var page2:PageData;
		
		public function PageSpreadData(_page1:PageData, _page2:PageData=null)
		{
			isSingle = (_page2 == null);
			
			page1 = _page1;
			
			if(!isSingle)
				page2 = _page2;
		}
	}
}