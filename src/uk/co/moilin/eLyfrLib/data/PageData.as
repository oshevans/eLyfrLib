package uk.co.moilin.eLyfrLib.data
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.controls.SWFLoader;

	public class PageData
	{
		public var pageImageURL:String;
		public var pageAudioURL:String;
		
		public function PageData(rawData:XML)
		{
			pageImageURL = rawData.image;
			pageAudioURL = rawData.audio;
		}
		
	}
}