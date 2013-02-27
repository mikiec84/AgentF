/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class GameView extends Sprite
	{
		public var units:Sprite;
       	public function GameView():void
	   	{
			visible = false;
	  	}
		public function addUnit(unit:DisplayObject):void
		{
			units.addChild(unit);
		}

		public function removeUnit(unit:DisplayObject):void
		{
			units.removeChild(unit);
		}
	}
}
