/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 06.03.13
 * Time: 19:32
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
	import starling.animation.IAnimatable;
	import starling.core.Starling;

	public class GameJuggler
	{
		private static var _running:Boolean = false;
		private static var _animatables:Vector.<IAnimatable> = new Vector.<IAnimatable>();
		public static function add(object:IAnimatable):void
		{
			if(_running)
				Starling.juggler.add(object);
			_animatables.push(object);
		}
		public static function remove(object:IAnimatable):void
		{
			if(_running)
				Starling.juggler.remove(object);
			_animatables.splice(_animatables.indexOf(object),1);
		}
		public static function start():void
		{
			if(_running)
				return;
			_running = true;
			for each(var obj:IAnimatable in _animatables)
				Starling.juggler.add(obj);
		}
		public static function stop():void
		{
			if(!_running)
				return;
			_running = false;
			for each(var obj:IAnimatable in _animatables)
				Starling.juggler.remove(obj);
		}

		public static function get running():Boolean
		{
			return _running;
		}

		public static function clear():void
		{
			stop();
			_animatables = new Vector.<IAnimatable>();
		}
	}
}
