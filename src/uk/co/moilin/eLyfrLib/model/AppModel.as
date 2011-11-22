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
			if(orientation == StageAspectRatio.PORTRAIT)
				return Capabilities.screenResolutionY > Capabilities.screenResolutionX ? Capabilities.screenResolutionY : Capabilities.screenResolutionX;
			else
				return Capabilities.screenResolutionY < Capabilities.screenResolutionX ? Capabilities.screenResolutionY : Capabilities.screenResolutionX;
		}
		
		public static function getWidth():Number
		{
			if(orientation == StageAspectRatio.LANDSCAPE)
				return Capabilities.screenResolutionX > Capabilities.screenResolutionY ? Capabilities.screenResolutionX : Capabilities.screenResolutionY;
			else
				return Capabilities.screenResolutionX < Capabilities.screenResolutionY ? Capabilities.screenResolutionX : Capabilities.screenResolutionY;
		}
	}
}