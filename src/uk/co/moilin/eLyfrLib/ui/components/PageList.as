package uk.co.moilin.eLyfrLib.ui.components
{
	import mx.charts.chartClasses.BoundedValue;
	import mx.collections.IList;
	import mx.events.FlexEvent;
	import mx.events.TouchInteractionEvent;
	
	import spark.components.List;
	import spark.components.supportClasses.ItemRenderer;
	import spark.effects.Animate;
	import spark.effects.animation.MotionPath;
	import spark.effects.animation.SimpleMotionPath;
	import spark.effects.easing.Sine;
	import spark.events.ListEvent;
	
	import uk.co.moilin.eLyfrLib.events.PageListEvent;
	import uk.co.moilin.eLyfrLib.model.AppModel;
	
	[Event(name="pageChange", type="uk.co.moilin.eLyfrLib.events.PageListEvent")]
	
	public class PageList extends List
	{
		
		protected var _currentPage:int;
		public function get currentPage():int { return _currentPage };
		public function set currentPage(value:int):void
		{
			if(value >= 0 && value < dataProvider.length)
				_currentPage = value;
		}
		
		public function PageList()
		{
			super();
			
			this.selectedIndex = _currentPage = 0;
			this.addEventListener(TouchInteractionEvent.TOUCH_INTERACTION_END, pageChangedHandler, false, 0, true);
		}
		
		override public function set dataProvider(value:IList):void
		{
			super.dataProvider = value;
// TODO: this is not working... need to make this change latter in the init process - when pages are being displayed
			this.layout.horizontalScrollPosition = AppModel.getWidth() * _currentPage;
		}
		
		public function gotoPage(_toPage:uint):void
		{
			if(_toPage >= 0 && _toPage < dataProvider.length)
			{
				_currentPage = _toPage;
				//this.layout.horizontalScrollPosition = AppModel.getWidth() * _currentPage;
				animPage(this.layout.horizontalScrollPosition, AppModel.getWidth() * _currentPage);
			}
		}
		
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
		
		/**
		 * Handles the scrolling touch interaction end event
		 * calculates the current page index and dispatches a PageListEvent.CHANGE
		 * 
		 * @param event TouchInteractionEvent
		 * 
		 */
		protected function pageChangedHandler(event:TouchInteractionEvent):void
		{
			if(this.pageScrollingEnabled)
			{
				var previousPage:int = _currentPage;
				_currentPage = this.scroller.horizontalScrollBar.value / AppModel.getWidth();
				if(previousPage != _currentPage) 
					dispatchEvent(new PageListEvent(PageListEvent.PAGE_CHANGE, true, false, previousPage, _currentPage));
			}
		}
	}
}