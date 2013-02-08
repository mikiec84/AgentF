/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:59
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import de.mediadesign.gd1011.studiof.services.JsonReader;

    import starling.display.Sprite;

    public class GUI extends Sprite
    {
		private var _config:Object;

		public function GUI()
        {
			_config=JsonReader.read("viewconfig")["GUI"];
        }

		public function addElement(element:GUIElement):void
		{
		}

		public function removeElement(element:GUIElement):void
		{
		}
    }
}
