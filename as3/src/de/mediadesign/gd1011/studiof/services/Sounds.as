/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 28.02.13
 * Time: 11:16
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	import starling.utils.AssetManager;



	public class Sounds
	{
		[Inject]
		public var assets:AssetManager;

		private var _bgSound:SoundChannel;
		private var _bgSoundQueue:Vector.<Sound>;
		private var _soundFX:Vector.<Sound>;

		public function Sounds()
		{
			_soundFX = new Vector.<Sound>();
			_bgSoundQueue = new Vector.<Sound>();
		}

		public function setBGSound(name:String):void
		{
			var sound:Sound = assets.getSound(name);
			_bgSoundQueue.push(sound);
			if(_bgSound==null)
			{
				_bgSound = sound.play();
				_bgSound.addEventListener(Event.SOUND_COMPLETE, loopBGSound);
			}
		}

		private function loopBGSound(e:Event):void
		{
			_bgSound.removeEventListener(Event.SOUND_COMPLETE, loopBGSound);
			if(_bgSoundQueue.length > 1)
				_bgSoundQueue.shift();
			_bgSound = _bgSoundQueue[0].play();
			_bgSound.addEventListener(Event.SOUND_COMPLETE, loopBGSound);
		}
	}
}
