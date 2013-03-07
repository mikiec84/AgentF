/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 06.03.13
 * Time: 21:00
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	import starling.display.Button;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;

	public class GameOverScreenView extends Sprite
	{
		public var restartButton:Button;
		public function GameOverScreenView(assets:AssetManager, level:Number)
		{
			addChild(assets.getImage("Lv"+(level+1)+"_PausenmenüHG"));

			var gameOverMessage:TopSecretTextfield = new TopSecretTextfield(Localization.getString("lose game"),90,0xcb1d01,HAlign.CENTER,0x0,false, false);
			gameOverMessage.y = 200;
			gameOverMessage.x = width/2;
			addChild(gameOverMessage);
			restartButton = new TopSecretButton(Localization.getString("restart"),JSONReader.read("viewconfig")["startscreen"]["button-size"]);
			restartButton.x = (this.width-restartButton.width)/2;
			restartButton.y = (this.height-restartButton.height)/2;
			addChild(restartButton);
		}
	}
}
