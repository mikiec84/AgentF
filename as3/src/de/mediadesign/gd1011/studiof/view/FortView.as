/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 07.03.13
 * Time: 15:03
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.consts.GameConsts;

	import starling.display.MovieClip;

	import starling.display.Sprite;
	import starling.utils.AssetManager;

	public class FortView extends Sprite
	{
		public function FortView(assets:AssetManager)
		{
			x = GameConsts.STAGE_WIDTH;
			addChild(assets.getImage("Fort_BackLayer"));
			addChild(assets.getImage("Fort_MidLayer"));
			addChild(assets.getImage("Fort_UpperLayer"));
			var door = new MovieClip(assets.getTextures("Clack_High_"), 1);
			door.stop();
			addChild(door);
			door = new MovieClip(assets.getTextures("Clack_Low_"), 1);
			door.stop();
			addChild(door);
		}
	}
}
