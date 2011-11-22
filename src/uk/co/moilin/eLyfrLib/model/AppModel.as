package uk.co.moilin.eLyfrLib.model
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageAspectRatio;
	import flash.display.StageOrientation;
	import flash.system.Capabilities;
	
	import spark.components.Application;

	public class AppModel
	{
		public static const IS_PORTRAIT:String = "is_portrait";
		public static const IS_LANDSCAPE:String = "is_landscape";
		
		public static var theStage:Stage;
		
		public static function get orientation():String
		{
			trace("stage: "+theStage);
			return theStage.stageWidth >= theStage.stageHeight ? StageAspectRatio.LANDSCAPE : StageAspectRatio.PORTRAIT;
		}
		
		public static function getHeight():Number
		{
			// TODO: this needs to take into consideration the Android nav bar (as per sony S) - could code exist in Sony P API for detecting it's presence?
			var rtrn:Number = 0;
			if(orientation == StageAspectRatio.PORTRAIT)
				rtrn = Capabilities.screenResolutionY > Capabilities.screenResolutionX ? Capabilities.screenResolutionY : Capabilities.screenResolutionX;
			else
				rtrn = Capabilities.screenResolutionY < Capabilities.screenResolutionX ? Capabilities.screenResolutionY : Capabilities.screenResolutionX;
			trace("HEIGHT: "+rtrn);			
			return rtrn;
		}
		
		public static function getWidth():Number
		{
			var rtrn:Number = 0;
			if(orientation == StageAspectRatio.LANDSCAPE)
				rtrn = Capabilities.screenResolutionX > Capabilities.screenResolutionY ? Capabilities.screenResolutionX : Capabilities.screenResolutionY;
			else
				rtrn = Capabilities.screenResolutionX < Capabilities.screenResolutionY ? Capabilities.screenResolutionX : Capabilities.screenResolutionY;
			trace("WIDTH: "+rtrn);
			return rtrn;
		}
	}
}