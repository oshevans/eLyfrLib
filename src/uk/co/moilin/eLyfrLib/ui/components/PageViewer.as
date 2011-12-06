package uk.co.moilin.eLyfrLib.ui.components
{
	import flash.display.StageAspectRatio;
	
	import mx.collections.IList;
	import mx.events.TouchInteractionEvent;
	
	import spark.effects.Animate;
	import spark.effects.animation.MotionPath;
	import spark.effects.animation.SimpleMotionPath;
	import spark.effects.easing.Sine;
	
	import uk.co.moilin.eLyfrLib.data.PageSpreadData;
	import uk.co.moilin.eLyfrLib.model.AppModel;
	
	public class PageViewer extends PageList
	{
		// PROPERTIES
		protected var _isSingleSpread:Boolean;
		public function get isSingleSpread():Boolean { return _isSingleSpread };
		public function set isSingleSpread(value:Boolean):void { _isSingleSpread = value };
		
		protected var _currentSpread:uint = 0;
		public function get currentSpread():uint{ return _currentSpread };
		public function set currentSpread(value:uint):void { _currentSpread = value };
		
		// METHODS
		/**
		 * Constructor
		 */
		public function PageViewer()
		{
			super();
// TODO: need to load all pages at startup, otherwise, nav next is jerky!! - it also unloads things after a period of time (garbage collection?)
		}
		
		/**
		 * Navigates to the next page spread
		 */
		public function gotoNextPage():void
		{
			gotoPage(++currentPage);
		}
		/**
		 * Navigates to the previous page spread
		 */
		public function gotoPrevPage():void
		{
			gotoPage(--currentPage);
		}
		
		// OVERRIDES
		/**
		 * Handles the scrolling touch interaction end event
		 * calculates the current page index and dispatches a PageListEvent.CHANGE
		 * 
		 * @param event TouchInteractionEvent
		 * 
		 */
		override protected function touchInteractionEndHandler(event:TouchInteractionEvent):void
		{
			super.touchInteractionEndHandler(event);
			
			_currentSpread = _isSingleSpread ? currentPage : currentPage * 2;
		}
		
		// FUNCTIONS
		
		/**
		 * Navigates to the specified page
		 * @param _toPage
		 * 
		 */
		protected function gotoPage(pageTo:uint):void
		{
			if(pageTo >= 0 && pageTo < dataProvider.length)
			{
				_currentSpread = _isSingleSpread ? currentPage : currentPage * 2;
				animPage(this.layout.horizontalScrollPosition, AppModel.getWidth() * currentPage);
			}
		}
		
		/**
		 * Animates the transition between page spreads
		 * @param posFrom
		 * @param posTo
		 * 
		 */
		private function animPage(posFrom:Number, posTo:Number):void
		{
			var animate:Animate = new Animate();
			var easer:Sine = new Sine();
			var paths:Vector.<MotionPath> = new Vector.<MotionPath>();
			paths.push(new SimpleMotionPath("horizontalScrollPosition", posFrom, posTo));
			animate.motionPaths = paths;
			animate.duration = 1000;
			animate.easer = easer;
			animate.target = this.layout;
			animate.play();
		}
	}
}