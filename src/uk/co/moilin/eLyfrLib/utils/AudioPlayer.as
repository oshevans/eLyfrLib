package uk.co.moilin.eLyfrLib.utils
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import uk.co.moilin.eLyfrLib.data.PageSpreadData;

	public class AudioPlayer
	{
		protected static var _firstPageAudio:Sound;
		protected static var _secondPageAudio:Sound;
		protected static var _currentlyPlaying:Sound;
		protected static var _channel:SoundChannel;
		protected static var _playDelay:Timer = new Timer(750);;
		
		/**
		 * Sets the sound object for the current page(s)
		 * @param pageIndex - index for page data
		 * 
		 */
		public static function setSpreadAudio(spreadData:PageSpreadData):void
		{
			// TODO: need to add delay before playing sound - delay by 1 second
			// TODO: change to _firstPageAudio and add _secondPageAudio
			// TODO: play second page audio once first one has completed
			
			_firstPageAudio = new Sound(new URLRequest(spreadData.page1.pageAudioURL));
			if(!spreadData.isSingle)
				_secondPageAudio = new Sound(new URLRequest(spreadData.page2.pageAudioURL));
			else
				_secondPageAudio = null;
			
			AudioPlayer.playAudio();
		}
		
		protected static function firstAudioCompleteHandler(event:Event):void
		{
			trace("AudioPlayer: firstAudioCompleteHandler");
			if(_secondPageAudio != null)
			{
				_currentlyPlaying = _secondPageAudio;
				_playDelay.start();
				_playDelay.addEventListener(TimerEvent.TIMER, playDelayHandler);
			}
		}
		
		public static function playAudio():void
		{
			trace("AudioPlayer: playAudio");
			if(_firstPageAudio != null)
			{
				_currentlyPlaying = _firstPageAudio;
				_playDelay.start();
				_playDelay.addEventListener(TimerEvent.TIMER, playDelayHandler);
			}
		}
		
		protected static function playDelayHandler(event:TimerEvent):void
		{
			_playDelay.removeEventListener(TimerEvent.TIMER, playDelayHandler);
			SoundMixer.stopAll();
			_channel = _currentlyPlaying.play();
			
			if(_secondPageAudio != null && _currentlyPlaying != _secondPageAudio)
				_channel.addEventListener(Event.SOUND_COMPLETE, firstAudioCompleteHandler);
			else
				_channel.removeEventListener(Event.SOUND_COMPLETE, firstAudioCompleteHandler);
		}
	}
}