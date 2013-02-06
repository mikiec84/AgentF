/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
	import de.mediadesign.gd1011.studiof.assets.Assets;


	import starling.display.Image;
	import starling.textures.Texture;

	public class Game
	{
		public var currentScore:int;

        private var player:Unit;

		public function Game():void
		{

			gameLoop();
		}

        public function gameLoop():void
        {

        }

	}
}
