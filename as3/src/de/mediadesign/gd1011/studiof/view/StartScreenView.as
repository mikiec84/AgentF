/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 14.02.13
 * Time: 14:31
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import starling.display.Sprite;

	public class StartScreenView extends Sprite
	{
		public var dimX:Number;
		public var dimY:Number;
		public function StartScreenView(width:Number,  height:Number)
		{
			dimX =width;
			dimY=height;
			visible = false;

		}

	}
}
