/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:59
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class GUI extends Sprite
    {
		private var _guiConfig:Object;

		private var _topLeft:Sprite = new Sprite();
		private var _topCenter:Sprite = new Sprite();
		private var _topRight:Sprite = new Sprite();

		private var _centerLeft:Sprite = new Sprite();
		private var _centerCenter:Sprite = new Sprite();
		private var _centerRight:Sprite = new Sprite();

		private var _bottomLeft:Sprite = new Sprite();
		private var _bottomCenter:Sprite = new Sprite();
		private var _bottomRight:Sprite = new Sprite();



		public function GUI()
        {
			if(stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE,init);


        }

		private function init(e:Event=null):void
		{
			//_guiConfig = JSONReader.read("viewconfig")["GUI"];

			_topLeft.x = _centerLeft.x = _bottomLeft.x = 20;//_guiConfig["padding"];
			_topCenter.x = _centerCenter.x = _bottomCenter.x = stage.stageWidth/2;
			_topRight.x = _centerRight.x = _bottomRight.x = stage.stageWidth-20;//_guiConfig["padding"];

			_topLeft.y = _topCenter.y = _topRight.y = 20; // _guiConfig["padding"];
			_centerLeft.y = _centerCenter.y = _centerRight.y = stage.stageHeight/2;
			_bottomLeft.y = _bottomCenter.y = _bottomRight.y = stage.stageHeight-20;//_guiConfig["padding"];

			addChild(_topLeft);
			addChild(_topCenter);
			addChild(_topRight);

			addChild(_centerLeft);
			addChild(_centerCenter);
			addChild(_centerRight);

			addChild(_bottomLeft);
			addChild(_bottomCenter);
			addChild(_bottomRight);
		}

		public function addElement(element:GUIElement):void
		{
			switch(element.vAlign)
			{
				case(VAlign.TOP):
					switch(element.hAlign)
					{
						case(HAlign.LEFT):
							break;
						case(HAlign.CENTER):
							break;
						case(HAlign.RIGHT):
							break;
					}
					break;
				case(VAlign.CENTER):
					switch(element.hAlign)
					{
						case(HAlign.LEFT):
							break;
						case(HAlign.CENTER):
							break;
						case(HAlign.RIGHT):
							break;
					}
					break;
				case(VAlign.BOTTOM):
					switch(element.hAlign)
					{
						case(HAlign.LEFT):
							break;
						case(HAlign.CENTER):
							break;
						case(HAlign.RIGHT):
							break;
					}
					break;
			}
		}

		public function removeElement(element:GUIElement):void
		{
		}
    }
}
