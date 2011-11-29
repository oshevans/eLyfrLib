package uk.co.moilin.eLyfrLib.ui.components
{
	import flash.display.StageAspectRatio;
	import flash.display.StageOrientation;
	import flash.events.StageOrientationEvent;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.events.TouchInteractionEvent;
	
	import spark.components.Group;
	import spark.components.List;
	
	import uk.co.moilin.eLyfrLib.data.BookData;
	import uk.co.moilin.eLyfrLib.data.PageData;
	import uk.co.moilin.eLyfrLib.data.PageSpreadData;
	import uk.co.moilin.eLyfrLib.events.PageListEvent;
	import uk.co.moilin.eLyfrLib.model.AppModel;
	import uk.co.moilin.eLyfrLib.model.AssetCache;
	import uk.co.moilin.eLyfrLib.utils.AudioPlayer;
	
	public class Viewer extends Group
	{
		// ELEMENTS
		public var pageViewer:PageList;
		
		// PROPERTIES
		
		// VARS
		protected var _bookData:BookData;
		protected var _pageSpreadData:ArrayCollection;
		protected var _currentPage:uint = 0;
		
		// METHODS
		private var _isSingleSpread:Boolean;
		public function Viewer()
		{
			super();
		}
		
		/**
		 * Parses the book data and initialises page viewer with spread data 
		 * @param value BookData
		 * 
		 */
		public function set bookData(value:BookData):void
		{
			trace("BookReader: set bookData");
			
			_bookData = value;
			
			AssetCache.initialiseCache(_bookData.pages);
			
			setOrientationPolicy();
			
			_pageSpreadData = new ArrayCollection(getPageSpreadData());
			
			pageViewer.dataProvider = _pageSpreadData;
		}
		
		/**
		 * Replays the audio for the current page(s) 
		 * 
		 */
		public function replayAudio():void
		{
			AudioPlayer.playAudio();
		}
		
		// OVERRIDES
		override public function initialize():void
		{
			trace("BookReader: initialize");
			super.initialize();
			
			AppModel.theStage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, orientationChangeHandler,false,0,true);
		}
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
			
			pageViewer.addEventListener(PageListEvent.PAGE_CHANGE, pageChangedHandler, false, 0, true);
			
			setSizes();
			
			AudioPlayer.setSpreadAudio(PageSpreadData(_pageSpreadData[_currentPage])); 
		}
		
		// FUNCTIONS
		/**
		 * Creates an array of page spread data objects
		 * @return Array of PageSpreadData
		 * 
		 */
		protected function getPageSpreadData():Array
		{
			trace("BookReader: initPageSpreadData");
			var numPages:uint = _bookData.pages.length;
			var spreadData:Array = new Array();
			
			_isSingleSpread = (AppModel.orientation==StageAspectRatio.PORTRAIT || _bookData.aspectRatio==StageAspectRatio.LANDSCAPE);
			
			for (var i:uint=0 ; i < numPages ; i++)
			{
				if(i==0) // first page is always a single page spread
				{
					spreadData.push(new PageSpreadData(_bookData.pages[i]));
					continue;
				}
					
				if(_isSingleSpread)
					spreadData.push(new PageSpreadData(_bookData.pages[i]));
				else
					spreadData.push(new PageSpreadData(_bookData.pages[i], _bookData.pages[++i]));
			}
			
			return spreadData;
		}
		
		/**
		 * Sets the size of screen elements based on the model size
		 */
		protected function setSizes():void
		{
			trace("BookReader: setSizes");
			pageViewer.x = this.x = 0;
			pageViewer.y = this.y = 0;
			pageViewer.width = this.width = AppModel.getWidth();
			pageViewer.height = this.height = AppModel.getHeight();
			
		}
		
		/**
		 * Sets the orientation policy for the app baseed on the book orientation settings
		 * 
		 */
		protected function setOrientationPolicy():void
		{
// BUG: this needs to be based on current device aspectRatio (stage.aspectRatio) - setting to portrait will flip stage if already in potrait/rotated_left
			if(_bookData.aspectRatio == StageAspectRatio.LANDSCAPE || _bookData.aspectRatio == StageAspectRatio.PORTRAIT)
			{
				AppModel.theStage.autoOrients = false;
				AppModel.theStage.setAspectRatio(_bookData.aspectRatio);
			}
		}
		
		// EVENT HANDLERS
		/**
		 * Handles the orientation cange event
		 * ensures that all visiual elements are updated, and that the page spread data is re-created for the new orientation 
		 * @param event StageOrientationEvent
		 * 
		 */
		protected function orientationChangeHandler(event:StageOrientationEvent):void
		{
			pageViewer.currentPage = _isSingleSpread ? _currentPage : _currentPage / 2;
			pageViewer.dataProvider = _pageSpreadData = new ArrayCollection(getPageSpreadData());

			setSizes();
		}
		
		protected function pageChangedHandler(event:PageListEvent):void
		{
			trace("OLD: "+event.oldIndex+", NEW: "+event.newIndex+", single: "+_isSingleSpread);
			_currentPage = _isSingleSpread ? event.newIndex : event.newIndex * 2;
			// Pass the current Spread to the audio player
			AudioPlayer.setSpreadAudio(_pageSpreadData[event.newIndex] as PageSpreadData);
		}
	}
}