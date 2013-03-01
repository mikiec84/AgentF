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
	import flash.utils.setInterval;
	import flash.utils.setTimeout;

	import starling.core.Starling;
	import starling.utils.AssetManager;

	public class Sounds
	{
		[Inject]
		public var assets:AssetManager;


		private var _bgSound:SoundChannel;
		private var _bgSoundQueue:Array;
		private var _soundFX:Vector.<SoundChannel>;
		private var _soundFXSounds:Vector.<Sound>;
		private var _pausePositions:Vector.<int>;
		private var _soundConfig:Object;

		private var _delay:Number = 0;


		public function Sounds()
		{
			_soundFX = new Vector.<SoundChannel>();
			_soundFXSounds = new Vector.<Sound>;
			_bgSoundQueue = new Array();
			_pausePositions = new Vector.<int>();
			_soundConfig = JSONReader.read("viewconfig")["soundsets"];
			_delay = _soundConfig["delay"];
			Starling.current.stage3D.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}

		public function play(key:String):void
		{
			var name:String = _soundConfig["generalsounds"][key];
			var sound:Sound = assets.getSound(name);
			_soundFXSounds.push(sound);
			_soundFX.push(sound.play());
			_soundFX[_soundFX.length-1].addEventListener(Event.SOUND_COMPLETE, stopFX);
		}

		public function setBGSound(level,key:String):void
		{
			var soundNames:Array = _soundConfig["level_"+(level+1)][key];
			var loopSounds:Vector.<Sound> = new Vector.<Sound>();
			for each(var name:String in soundNames)
			{
				var sound:Sound = assets.getSound(name);
				loopSounds.push(sound);
			}
			if(loopSounds.length==0)
				return;

			_bgSoundQueue.push(loopSounds);

			if(_bgSound==null)
			{
				_bgSound = loopSounds[0].play();
				if(_bgSound!= null)
				{
					setInterval(watchBGSound,_delay*0.1);
					//_bgSound.addEventListener(Event.SOUND_COMPLETE, loopBGSound);
				}
			}
		}

		private function loopBGSound(e:Event = null):void
		{

			_bgSound.removeEventListener(Event.SOUND_COMPLETE, loopBGSound);
			if(_bgSoundQueue.length > 1)
				_bgSoundQueue.shift();
			else
				_bgSoundQueue[0].push(_bgSoundQueue[0].shift());

			_bgSound = _bgSoundQueue[0][0].play();
			setInterval(watchBGSound,_delay*0.1);
			//_bgSound.addEventListener(Event.SOUND_COMPLETE, loopBGSound);
		}

		private function watchBGSound():void
		{
			if(_bgSound==null)
				return;
			if(_bgSoundQueue[0][0].length-_bgSound.position <=_delay )
				loopBGSound();
		}

		private function stage_deactivateHandler(e:Event):void
		{
			if(_bgSound != null)
			{
				_pausePositions[0] = _bgSound.position;
				_bgSound.stop();
				_bgSound = null;
			}
			for each (var sfx in _soundFX)
			{
				_pausePositions.push(sfx.position);
				sfx.stop();
			}
			_soundFX = new Vector.<SoundChannel>();
			Starling.current.stage3D.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}

		private function stage_activateHandler(e:Event):void
		{
			Starling.current.stage3D.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			if(_bgSoundQueue.length>0)
			{
				_bgSound = _bgSoundQueue[0][0].play(_pausePositions.shift());
				if(_bgSound!= null)
					_bgSound.addEventListener(Event.SOUND_COMPLETE, loopBGSound);
			}

			for each (var sound:Sound in _soundFXSounds)
			{
				_soundFX.push(sound.play(_pausePositions.shift()));
				_soundFX[_soundFX.length-1].addEventListener(Event.SOUND_COMPLETE, stopFX);
			}
		}

		private function stopFX(e:Event):void
		{
			var soundchannel:SoundChannel = e.currentTarget as SoundChannel;
			var id:int = _soundFX.indexOf(soundchannel);
			_soundFX.splice(id, 1);
			_soundFXSounds.splice(id,1);
		}
	}
}
