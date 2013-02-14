/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 14.02.13
 * Time: 14:31
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.services.Assets;

	import starling.display.Button;
	import starling.display.Sprite;

	public class StartScreenView extends Sprite
	{
		public var startButton:Button;

		public function StartScreenView(width:Number,  height:Number)
		{
			startButton = new Button(Assets.getTexture("E2_texture"), "start", Assets.getTexture("Pause_texture"));

			startButton.x = (width - startButton.width) / 2;
			startButton.y = (height - startButton.height) / 2;
			addChild(startButton);
		}

	}
}
