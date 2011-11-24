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
		private var _pageImageURL:String;
		public function get pageImageURL():String { return _pageImageURL };

		private var _pageAudioURL:String;
		public function get pageAudioURL():String { return _pageAudioURL };
		
		public function PageData(rawData:XML)
		{
			_pageImageURL = rawData.image;
			_pageAudioURL = rawData.audio;
		}
		
	}
}