/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 28.02.13
 * Time: 11:16
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
	import de.mediadesign.gd1011.studiof.AgentF;
	import de.mediadesign.gd1011.studiof.view.MainView;

	import flash.display.Stage3D;

	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.impl.Context;

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

		public function Sounds()
		{
			_soundFX = new Vector.<SoundChannel>();
			_soundFXSounds = new Vector.<Sound>;
			_bgSoundQueue = new Array();
			_pausePositions = new Vector.<int>();
			_soundConfig = JSONReader.read("viewconfig")["soundsets"];
		}

		public function play(key:String):void
		{

		}

		public function setBGSound(level,key:String):void
		{
			var soundName:Array = _soundConfig["level_"+(level+1)][key];
			var loopSounds:Vector.<Sound> = new Vector.<Sound>();
			for each(var name:String in soundName)
			{
				var sound:Sound = assets.getSound(name);
				loopSounds.push(sound);
			}

			_bgSoundQueue.push(loopSounds);

			if(_bgSound==null)
			{
				_bgSound = loopSounds[0].play();
				if(_bgSound!= null)
				{
					_bgSound.addEventListener(Event.SOUND_COMPLETE, loopBGSound);
					Starling.current.stage3D.addEventListener(flash.events.Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
				}
			}
		}

		private function stage_deactivateHandler(e:Event):void
		{
			if(_bgSound != null)
			{
				_pausePositions[0] = _bgSound.position;
				_bgSound.stop();
				_bgSound = null;
			}
			Starling.current.stage3D.addEventListener(flash.events.Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}

		private function stage_activateHandler(e:Event):void
		{
			Starling.current.stage3D.removeEventListener(flash.events.Event.ACTIVATE, stage_activateHandler);
			if(_bgSoundQueue.length>0)
			{
				_bgSound = _bgSoundQueue[0][0].play(_pausePositions[0]);
				if(_bgSound!= null)
					_bgSound.addEventListener(Event.SOUND_COMPLETE, loopBGSound);
			}

		}

		private function loopBGSound(e:Event):void
		{
			_bgSound.removeEventListener(Event.SOUND_COMPLETE, loopBGSound);
			if(_bgSoundQueue.length > 1)
				_bgSoundQueue.shift();
			else
				_bgSoundQueue[0].push(_bgSoundQueue[0].shift());

			_bgSound = _bgSoundQueue[0][0].play();
			_bgSound.addEventListener(Event.SOUND_COMPLETE, loopBGSound);
		}
	}
}
