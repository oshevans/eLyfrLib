package uk.co.moilin.eLyfrLib
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	import mx.events.FlexEvent;
	
	import spark.components.Application;
	import spark.components.ViewNavigator;
	
	import uk.co.moilin.eLyfrLib.data.SeriesData;
	import uk.co.moilin.eLyfrLib.events.BookReaderEvent;
	import uk.co.moilin.eLyfrLib.model.AppModel;
	import uk.co.moilin.eLyfrLib.ui.BookView;
	import uk.co.moilin.eLyfrLib.ui.MenuView;
	
	/**
	 * Main application class for the BookReader 
	 * @author oevans
	 * 
	 */
	public class BookReader extends Application
	{
		// ELEMENTS
		public var mainView:ViewNavigator;
		
		// PROPERTIES
		[Bindable]
		public var seriesDataFile:String;
		
		// VARS
		protected var seriesData:SeriesData;
		protected var rawSeriesData:XML;
		
		// METHODS
		public function BookReader()
		{
			super();
		}
		
		/**
		 * Initialise the application by getting the config file 
		 * 
		 */
		override public function initialize():void
		{
			trace("BookReader: initialize");
			super.initialize();
			
			var fileLoader:URLLoader = new URLLoader();
			fileLoader.dataFormat = URLLoaderDataFormat.TEXT;
			fileLoader.addEventListener(Event.COMPLETE, configLoadedHandler);
			fileLoader.load(new URLRequest(seriesDataFile));
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		/**
		 * Handles the added to stage event.
		 * Further initialises the app
		 * @param event Event
		 * 
		 */
		protected function addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			// Initialise the app model
			AppModel.theStage = this.stage;
		}
		
		// FUNCTIONS
		/**
		 * Hnaldes the loading event for the configuration file
		 * Parse the config file further initialising the app and setting up the initial view  
		 * @param event Event
		 * 
		 */
		protected function configLoadedHandler(event:Event):void
		{
			trace("BookReader: configLoadedHandler");
			
			// Parse config data
			rawSeriesData = new XML(URLLoader(event.target).data);
			seriesData = new SeriesData(rawSeriesData);
			
			// TODO: set orientation policy based on config data - e.g. some books are landscape only
			
			// Set up the menu
			initMenu();
		}
		
		/**
		 * Initialise the menu view 
		 * 
		 */
		private function initMenu():void
		{
			trace("BookReader: initMenu");
			mainView.popAll();
			mainView.pushView(MenuView,seriesData);
			mainView.visible = true;
			mainView.addEventListener(BookReaderEvent.ITEM_SELECTED, menuItemSelectedHandler);
		}
		
		// EVENT HANDLERS
		/**
		 * Handles the selection of a menu item 
		 * @param event BookReaderEvent
		 * 
		 */
		protected function menuItemSelectedHandler(event:BookReaderEvent):void
		{
			trace("BookReader: menuItemSelectedHandler");
			
			mainView.pushView(BookView, seriesData.books[event.selectedBook]);
			mainView.addEventListener(BookReaderEvent.HOME_BUTTON_SELECTED, homeSelectedHandler);
		}
		
		/**
		 * Handles the navigate to home equest
		 * Opens the menu view  
		 * @param event
		 * 
		 */
		protected function homeSelectedHandler(event:Event):void
		{
			trace("BookReader: homeSelectedHandler");
			mainView.removeEventListener(BookReaderEvent.HOME_BUTTON_SELECTED, homeSelectedHandler);
			
			// Pop to the menu view
			mainView.popToFirstView();
		}
	}
}