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
	import starling.text.TextField;

	public class GUI extends Sprite
    {
		private var _config:Object;
        private var _enemyConfig:Object;

		private var _topLeft:Sprite;
		private var _topCenter:Sprite;
		private var _topRight:Sprite;
		private var _centerCenter:Sprite;

		private var _lifepoints:TextField;
		private var _gameOverScreen:TextField;
        private var _enemiesKilled:TextField;

        private var enemyKilledCounter:int = 0;

		public function GUI()
        {
            _config = JSONReader.read("viewconfig")["gui"];
            _enemyConfig = JSONReader.read("enemy")["ENEMY"];

			_topLeft 		= new Sprite();
			_topCenter 		= new Sprite();
			_topRight 		= new Sprite();
			_centerCenter 	= new Sprite();
			addChild(_topLeft);
			addChild(_topCenter);
			addChild(_topRight);
			addChild(_centerCenter);

			_lifepoints = new TextField(200,100,"3","Verdana",60,0xffffff,true);
			_topLeft.addChild(_lifepoints);
            _enemiesKilled = new TextField(1000, 100, "Enemies killed: 0/"+_enemyConfig["enemyCount"], "Verdana", 60, 0xffffff, true);
            _topCenter.addChild(_enemiesKilled);
            _enemiesKilled.x -= 500;
            _enemiesKilled.y -= 20;
			if(stage)
				adjust();
			else
				addEventListener(Event.ADDED_TO_STAGE,adjust);

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
			_lifepoints.text=points.toString();
		}

        public function setEnemiesKilled(points:int):void
        {   ++enemyKilledCounter;
            _enemiesKilled.text = "Enemies killed: "+enemyKilledCounter.toString()+"/"+_enemyConfig["enemyCount"];
        }

		public function showGameOver(won:Boolean):void
		{
			_gameOverScreen = new TextField(1000,200,"","Verdana",60,0xffffff,true);
			_gameOverScreen.x = -_gameOverScreen.width/2;
			_gameOverScreen.y = -_gameOverScreen.height/2;
			if(won)
				_gameOverScreen.text="Your victory is now fact.";
			else
				_gameOverScreen.text="Your loss is assured!"
			_centerCenter.addChild(_gameOverScreen);
		}
    }
}
