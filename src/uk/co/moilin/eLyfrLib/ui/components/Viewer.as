package uk.co.moilin.eLyfrLib.ui.components
{
	import flash.display.StageAspectRatio;
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
	import uk.co.moilin.eLyfrLib.model.AppModel;
	import uk.co.moilin.eLyfrLib.model.AssetCache;
	
	public class Viewer extends Group
	{
		// ELEMENTS
		public var pageViewer:List;
		
		// PROPERTIES
		
		// VARS
		protected var _bookData:BookData;
		protected var _pageSpreadData:ArrayCollection;
		
		protected var _pageAudio:Sound;
		
		// METHODS
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
			trace("BookReader: initialize");
			
			_bookData = value;
			
			AssetCache.initialiseCache(_bookData.pages);
			
			_pageSpreadData = new ArrayCollection(getPageSpreadData());
			
			pageViewer.dataProvider = _pageSpreadData;
		}
		
		/**
		 * Initialises the viewer
		 * 
		 */
		override public function initialize():void
		{
			trace("BookReader: initialize");
			super.initialize();
			
			AppModel.theStage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, orientationChangeHandler,false,0,true);
		}
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
			
			pageViewer.addEventListener(TouchInteractionEvent.TOUCH_INTERACTION_END, pageChangedHandler, false, 0, true);
			
			setSizes();
			playAudio();
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
			
			for (var i:uint=0 ; i < numPages ; i++)
			{
				// TODO: how to get reference to Stage?
				if(AppModel.orientation == StageAspectRatio.PORTRAIT)
				{
					spreadData.push(new PageSpreadData(_bookData.pages[i]));
				} else {
					spreadData.push(new PageSpreadData(_bookData.pages[i], _bookData.pages[++i]));
				}
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
		 * Plays the audio associated with the current page(s)  
		 * 
		 */
		protected function playAudio():void
		{
			SoundMixer.stopAll();
			trace("BookReader: playAudio");
			if(_pageAudio != null)
				_pageAudio.play();
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
			trace("BookReader: orientationChangeHandler"+event.afterOrientation);
			// TODO: use currPage to keep track of page when changing orientation
			trace("Watch out, we've been tipped to "+event.afterOrientation+" orientation.");
			
			pageViewer.dataProvider = _pageSpreadData = new ArrayCollection(getPageSpreadData());
			
			setSizes();
		}
		/**
		 * Handles the pageViewer 'page change' event when the list is scrolled
		 * Plays the page audio
		 * @param event TouchInteractionEvent
		 * 
		 */
		protected function pageChangedHandler(event:TouchInteractionEvent):void
		{
			// TODO: change this so that the pageViewer dispatches a ViewerPageChange event that indicates the new and old pages
			trace("BookReader: pageChangedHandler");
			// TODO: use code from S4C DailyView to get currently viewed PageItemRenderer
			trace("NEED TO GET CURRENT PAGE BEIGN DISPLAYED");
			_pageAudio  = new Sound(new URLRequest(PageData(_bookData.pages[0]).pageAudioURL));
			playAudio();
		}
	}
}