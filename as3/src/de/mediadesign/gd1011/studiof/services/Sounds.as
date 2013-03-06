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
	import flash.media.SoundTransform;
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
		private var _bgLoopSettings:Array;
		private var _soundFX:Vector.<SoundChannel>;
		private var _soundFXSounds:Vector.<Sound>;
		private var _soundFXVolume:Vector.<Number>;
		private var _pausePositions:Vector.<int>;
		private var _soundConfig:Object;

		private var _delay:Number = 0;


		public function Sounds()
		{
			_soundFX = new Vector.<SoundChannel>();
			_soundFXSounds = new Vector.<Sound>;
			_soundFXVolume = new Vector.<Number>();
			_bgSoundQueue = new Array();
			_bgLoopSettings = new Array();
			_pausePositions = new Vector.<int>();
			_soundConfig = JSONReader.read("viewconfig")["soundsets"];
			_delay = _soundConfig["delay"];
			Starling.current.stage3D.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}

		public function play(key:String, volume:Number = 1.0):void
		{
			var name:String = _soundConfig["general"][key];
			var sound:Sound = assets.getSound(name);
			_soundFXSounds.push(sound);
			_soundFX.push(sound.play());
			_soundFXVolume.push(volume);
			_soundFX[_soundFX.length-1].soundTransform.volume = volume;
			_soundFX[_soundFX.length-1].addEventListener(Event.SOUND_COMPLETE, stopFX);
		}

		public function setBGSound(level,key:String, forceCompleteLoop:Boolean = false, loop:Boolean = true):void
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
			var loopSettings:Array = new Array(0,forceCompleteLoop,loop);
			_bgLoopSettings.push(loopSettings);

			_bgSoundQueue.push(loopSounds);

			if(_bgSound==null)
			{
				_bgSound = loopSounds[0].play();
				if(_bgSound!= null)
				{
					setInterval(watchBGSound,_delay*0.1);
				}
			}
		}

		//Alternative Complete-Event
		private function loopBGSound():void
		{

			if((_bgSoundQueue.length > 1) &&
			   (_bgLoopSettings[0][1] == false || _bgLoopSettings[0][0] == _bgSoundQueue[0].length-1))//If no complete loop forced or at the end of the loop, skip rest
			{
				_bgSoundQueue.shift();
				_bgLoopSettings.shift();
			}
			else
			{
				_bgSoundQueue[0].push(_bgSoundQueue[0].shift());
				_bgLoopSettings[0][0]++;
			}

			if(_bgLoopSettings[0][2] == false && _bgLoopSettings[0][0] == _bgSoundQueue[0].length)
			{
				_bgSoundQueue.shift();
				_bgLoopSettings.shift();
			}
			else
			{
				_bgLoopSettings[0][0]=_bgLoopSettings[0][0]%_bgSoundQueue[0].length;
			}

			if(_bgSoundQueue.length > 0)
			{
				_bgSound = _bgSoundQueue[0][0].play();
				if(_bgSound!= null)
				{
					setInterval(watchBGSound,_delay*0.1);
				}
			}

		}

		private function watchBGSound():void
		{
			if(_bgSound==null || _bgSoundQueue[0] == null)
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
				_soundFX[_soundFX.length-1].soundTransform.volume = _soundFXVolume[_soundFX.indexOf(sound)];
				_soundFX[_soundFX.length-1].addEventListener(Event.SOUND_COMPLETE, stopFX);
			}
		}

		private function stopFX(e:Event):void
		{
			var soundchannel:SoundChannel = e.currentTarget as SoundChannel;
			var id:int = _soundFX.indexOf(soundchannel);
			_soundFX.splice(id, 1);
			_soundFXVolume.splice(id, 1);
			_soundFXSounds.splice(id,1);
		}
	}
}
