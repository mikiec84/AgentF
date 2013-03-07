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
	import de.mediadesign.gd1011.studiof.view.TopSecretTexture;

	import flash.display.BitmapData;

	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class GUI extends Sprite
    {
		private var _config:Object;
        private var _enemyConfig:Object;

		private var _topLeft:Sprite;
		private var _topCenter:Sprite;
		private var _topRight:Sprite;
		private var _centerCenter:Sprite;

		private var _guiScale:Number = 1;
		private var _appScale:Number = 1;

		public var lifepoints:LifePointsView;
		public var pauseMenu:PauseMenuView;
		public var gameOverScreen:GameOverScreenView;
        private var _enemiesKilled:TopSecretTextfield;
		public var pauseButton:Button;

        private var enemyKilledCounter:Number = 0;

		public function GUI(guiScale:Number,appScale:Number):void
        {
			_guiScale = guiScale;
			_appScale = appScale;
            _config = JSONReader.read("viewconfig")["gui"];
            _enemyConfig = JSONReader.read("enemy")["ENEMY"];

			_topLeft 		= new Sprite();
			_topCenter 		= new Sprite();
			_topRight 		= new Sprite();
			_centerCenter 	= new Sprite();
			_topLeft.scaleX = _topLeft.scaleY = _topCenter.scaleX = _topCenter.scaleY =_topRight.scaleX = _topRight.scaleY = guiScale;
			scaleGame(_centerCenter);

			addChild(_topLeft);
			addChild(_topCenter);
			addChild(_topRight);
			addChild(_centerCenter);

            _enemiesKilled = new TopSecretTextfield("0",60,0xcb1d01,HAlign.CENTER);
            _topCenter.addChild(_enemiesKilled);
			if(stage)
				adjust();
			else
				addEventListener(Event.ADDED_TO_STAGE,adjust);

        }

		public function scaleGUI(object:DisplayObject):void
		{
			object.scaleX = object.scaleY = _guiScale;
		}

		public function scaleGame(object:DisplayObject):void
		{
			object.scaleX = object.scaleY = _appScale;
		}

		public function addAdjusted(object:DisplayObject, vAlign:String, hAlign:String):void
		{
			switch (vAlign)
			{
				case (VAlign.TOP):
					switch (hAlign)
					{
						case (HAlign.RIGHT):
							_topRight.addChild(object);
							break;
					}
					break;
				case (VAlign.CENTER):
					switch (hAlign)
					{
						case (HAlign.CENTER):
							_centerCenter.addChild(object);
							object.x = -object.width/2;
							object.y = -object.height/2;
							break;
					}
					break;
			}
		}
		private function adjust(e:Event=null):void
		{   removeEventListener(Event.ADDED_TO_STAGE, adjust);
			_topLeft.x											= _config["padding"];
			_topCenter.x 	= _centerCenter.x 					= getWidth()/2;
			_topRight.x											= getWidth();
			_topLeft.y		= _topCenter.y		= _topRight.y	= _config["padding"];
			_centerCenter.y 									= getHeight()/2;

		}


		private function getWidth():Number
		{
			if(stage)
				return stage.stageWidth/scaleX;
			return 0;
		}

		private function getHeight():Number
		{
			if(stage)
				return stage.stageHeight/scaleY;
			return 0;
		}

		public function setLifepoints(points:int):void
		{
			lifepoints.points = points;
		}


        public function setEnemiesKilled(points:int):void
        {   ++enemyKilledCounter;
			_enemiesKilled.text = enemyKilledCounter+"00";

        }

    }
}
