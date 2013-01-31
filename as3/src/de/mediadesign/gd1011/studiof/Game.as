/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof
{
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    import starling.display.Sprite;
	import starling.text.TextField;

	public class Game extends Sprite
	{
		public function Game()
		{
	        var t:TextField = new TextField(300,300,"Test:");
            addChild(t);

		}
	}
}
