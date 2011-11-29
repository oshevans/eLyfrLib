package uk.co.moilin.eLyfrLib.model
{
	import flash.system.Capabilities;
	
	import mx.controls.SWFLoader;
	
	import uk.co.moilin.eLyfrLib.data.PageData;

	public class AssetCache
	{
		private static var cacheLibrary:Array;
		
		public static function initialiseCache(pagesData:Array):void
		{
			cacheLibrary = new Array();
			
			for each (var pageData:PageData in pagesData)
			{
				var swfLoader:SWFLoader = new SWFLoader();
				swfLoader.setStyle("horizontalAlign", "center");
				swfLoader.setStyle("verticalAlign", "middle");
				swfLoader.scaleContent = true;
				swfLoader.cacheAsBitmap = true;
				swfLoader.smoothBitmapContent = true;
				swfLoader.source = pageData.pageImageURL;
// TODO: I don't think this is loading them properly, as there is a big delay when each page is loaded for the first time
// TODO: it also seems to be removed after a period of time - leaving the book for a while means that there is again a big delay when each page is loaded for the first time
				
				cacheLibrary.push(swfLoader);
			}
		}
		
		public static function getSWFLoaderInstance(sourceName:String):SWFLoader
		{
			for each (var loader:SWFLoader in cacheLibrary)
			{
				if(loader.source == sourceName)
				{
					return loader;
				}
			}
			return null;
		}
	}
}