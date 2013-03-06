package de.mediadesign.gd1011.studiof.view.mediators
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;
	import de.mediadesign.gd1011.studiof.services.GameJuggler;
	import de.mediadesign.gd1011.studiof.services.LevelProcess;
    import de.mediadesign.gd1011.studiof.services.GameLoop;
    import de.mediadesign.gd1011.studiof.services.JSONReader;
    import de.mediadesign.gd1011.studiof.view.BackgroundView;
    import de.mediadesign.gd1011.studiof.view.GameView;

    import flash.events.IEventDispatcher;
    import flash.geom.Point;

    import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.core.Starling;

	import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.MovieClip;

	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.utils.AssetManager;

    public class GameViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:GameView;

        [Inject]
        public var game:GameLoop;

		[Inject]
		public var level:LevelProcess;

        [Inject]
        public var dispatcher:IEventDispatcher;

		[Inject]
		public var assets:AssetManager;

        private var splashImage:MovieClip;
        private var explosions:Vector.<MovieClip>;

		private var _touchConfig:Object;
		private var _validTouchID:int = -1;
		private var _startTouchPos:Point;
		private var _timeStamp:Number;

        private var doorO:MovieClip;
        private var doorO2:MovieClip;
        private var doorU:MovieClip;
        private var doorU2:MovieClip;
		
		override public function initialize():void
		{
			var backgroundView:BackgroundView = new BackgroundView();
			contextView.addChild(backgroundView);

			_touchConfig = JSONReader.read("viewconfig")["game"];

			contextView.addEventListener(TouchEvent.TOUCH, handleTouch);
            contextView.addEventListener(EnterFrameEvent.ENTER_FRAME, game.update);

			contextView.units = new Sprite();
			contextView.addChild(contextView.units);

            explosions = new Vector.<MovieClip>();

            addContextListener(ViewConsts.ADD_WATER_TO_GAME, addWater);
            addContextListener(ViewConsts.ADD_SPRITE_TO_GAME, add);
			addContextListener(ViewConsts.REMOVE_SPRITE_FROM_GAME, remove);
            addContextListener(ViewConsts.CREATE_FORTBG, createFort);
            addContextListener(ViewConsts.SPLASH, showSplash);
            addContextListener(ViewConsts.EXPLOSION, showExplosion);
            addContextListener(ViewConsts.REMOVE_EXP, removeExplosions);

			var initGameEvent:GameEvent = new GameEvent(GameConsts.INIT_GAME);
			dispatcher.dispatchEvent(initGameEvent);
			contextView.visible = true;
		}

        private function createFort(event:GameEvent):void
        {
            removeContextListener(ViewConsts.CREATE_FORTBG, createFort);
            var fortBackLayer:Image = new Image(assets.getTexture("Fort_BackLayer"));
            fortBackLayer.x = GameConsts.STAGE_WIDTH - 890;
            fortBackLayer.y = 0;
            contextView.addChildAt(fortBackLayer, contextView.numChildren-2);
            var fortMiddleLayer:Image = new Image(assets.getTexture("Fort_MidLayer"));
            fortMiddleLayer.x = GameConsts.STAGE_WIDTH - 890;
            fortMiddleLayer.y = 0;
            contextView.addChildAt(fortMiddleLayer, contextView.numChildren-2);
            var fortUpperLayer:Image = new Image(assets.getTexture("Fort_UpperLayer"));
            fortUpperLayer.x = GameConsts.STAGE_WIDTH - 890;
            fortUpperLayer.y = 0;
            contextView.addChildAt(fortUpperLayer, contextView.numChildren-1);

            doorO = new MovieClip(assets.getTextures("Clack_High_"),30);
			GameJuggler.add(doorO as MovieClip);
            doorO.x = GameConsts.STAGE_WIDTH - 890;
            doorO.y = 0;
            (doorO as MovieClip).stop();
            doorO.loop = false;
            contextView.addChild(doorO);

            doorO2 = assets.getMCReverse("Clack_High_");
			GameJuggler.add(doorO2 as MovieClip);
            doorO2.x = GameConsts.STAGE_WIDTH - 890;
            doorO2.y = 0;
            (doorO2 as MovieClip).stop();
            doorO2.loop = false;

            doorU = new MovieClip(assets.getTextures("Clack_Low_"),30);
			GameJuggler.add(doorU as MovieClip);
            doorU.x = GameConsts.STAGE_WIDTH - 890;
            doorU.y = 0;
            (doorU as MovieClip).stop();
            doorU.loop = false;
            contextView.addChild(doorU);

            doorU2 = assets.getMCReverse("Clack_Low_");
			GameJuggler.add(doorU2 as MovieClip);
            doorU2.x = GameConsts.STAGE_WIDTH - 890;
            doorU2.y = 0;
            (doorU2 as MovieClip).stop();
            doorU2.loop = false;

            addContextListener(ViewConsts.UPPER_DOOR, handleUpperDoor);
            addContextListener(ViewConsts.NETHER_DOOR, handleNetherDoor);
        }

        private function handleNetherDoor(event:GameEvent):void
        {
            if (doorU.currentFrame == 0)
            {
                contextView.removeChild(doorU2);
                contextView.addChild(doorU);
                doorU.play();
                doorU2.stop();
                doorU2.currentFrame = 0;
            }
            else if (doorU.currentFrame == 30)
            {
                contextView.removeChild(doorU);
                contextView.addChild(doorU2);
                doorU2.play();
                doorU.stop();
                doorU.currentFrame = 0;
            }
        }

        private function handleUpperDoor(event:GameEvent):void
        {
            if (doorO.currentFrame == 0)
            {
                contextView.removeChild(doorO2);
                contextView.addChild(doorO);
                doorO.play();
                doorO2.stop();
                doorO2.currentFrame = 0;
            }
            else if (doorO.currentFrame == 30)
            {
                contextView.removeChild(doorO);
                contextView.addChild(doorO2);
                doorO2.play();
                doorO.stop();
                doorO.currentFrame = 0;
            }
        }

        private function showSplash(event:GameEvent):void
        {
            splashImage = new MovieClip(assets.getTextures("Splash_"), 15);
            splashImage.alpha = 0.5;
            splashImage.x = -30;
            splashImage.y = GameConsts.STAGE_HEIGHT/2 - 156;
            GameJuggler.add(splashImage);
            splashImage.loop = false;
            splashImage.play();
            contextView.addChild(splashImage);
        }

        public function showExplosion(event:GameEvent):void
        {
            var explosionImg:MovieClip;

            if (event.dataObj.verticalBullet)
            {
                if (event.dataObj.position.y <= GameConsts.STAGE_HEIGHT/2)
                    explosionImg = new MovieClip(assets.getTextures("exp_"), 30);
                else
                    explosionImg = new MovieClip(assets.getTextures("wExp_"), 30);

                explosionImg.x = event.dataObj.position.x - 156;
                explosionImg.y = event.dataObj.position.y - 256;
            }
            else
            {
                if (event.dataObj.currentPlatform == 2)
                    explosionImg = new MovieClip(assets.getTextures("exp_"), 30);
                else if (event.dataObj.currentPlatform >= 3)
                    explosionImg = new MovieClip(assets.getTextures("wExp_"), 30);

                explosionImg.x = event.dataObj.position.x - 256;
                explosionImg.y = event.dataObj.position.y - 256;
            }

			GameJuggler.add(explosionImg);
            explosionImg.loop = false;
            explosionImg.play();

            explosions.push(explosionImg);

            contextView.addChild(explosionImg);
        }

        public function removeExplosions(event:GameEvent):void
        {
            for (var i:int = 0; i < explosions.length; i++)
            {
                if (explosions[i].currentFrame == 11)
                {
                    contextView.removeChild(explosions[i]);
                    explosions.splice(i, 1);
                }
            }
            if (splashImage != null && splashImage.currentFrame >= 6)
            {
                contextView.removeChild(splashImage);
            }
        }

        public function addWater(event:GameEvent):void
        {
            var water:MovieClip = assets.getAsset("Water_") as MovieClip;
            water.fps = 5;
            water.y = 455;
            water.alpha = 0.5;
			GameJuggler.add(water);
            contextView.addChild(water);
            water.play();
        }

		override public function destroy():void
		{
            contextView.removeEventListener(TouchEvent.TOUCH, handleTouch);
            contextView.removeEventListener(EnterFrameEvent.ENTER_FRAME, game.update);
		}

		private function add(event:GameEvent):void
		{
            contextView.addUnit(event.dataObj as DisplayObject);
		}

        private function remove(event:GameEvent):void
        {
            contextView.removeUnit(event.dataObj as DisplayObject);
        }

		private function handleTouch(e:TouchEvent):void
		{
			var vTouchPos:Number;
			var platform:int;

			//Handle starting touches
			var initTouches:Vector.<Touch> = e.getTouches(contextView, TouchPhase.BEGAN);
			for (var i:int = 0; i < initTouches.length; i++)
			{
				if (initTouches[i].getLocation(contextView).x <= _touchConfig["hTouch"])
				{
					vTouchPos = initTouches[i].getLocation(contextView).y;
					platform = getVTouchzone(vTouchPos);

					if(platform>=0 && _touchConfig["vTouch"][platform]<=vTouchPos && _touchConfig["vTouch"][platform+1]>=vTouchPos)
					{
						_validTouchID = initTouches[i].id;
						_startTouchPos = initTouches[i].getLocation(contextView);
						_timeStamp = e.timestamp;
						if(level.player != null && platform >=0 && platform != level.player.targetPlatform)
						{
							level.player.targetPlatform = platform;
						}
					}
				}
			}

			//Handle moves
			var touches:Vector.<Touch> = e.getTouches(contextView, TouchPhase.MOVED);
			for (var j:int = 0; j < touches.length; j++)
				if (touches[j].id == _validTouchID)
				{
					vTouchPos = touches[j].getLocation(contextView).y;
					platform = getVTouchzone(vTouchPos);

					//Move-down
					if(touches[j].getMovement(contextView).y>0 && platform < _touchConfig["defaultZone"])
					{
						if(level.player != null)
						{

						}
					}

					//Switch platform
					if(level.player != null && platform >=0 && platform != level.player.targetPlatform)
					{
						level.player.targetPlatform = platform;
					}
				}

			//Handle end touch
			var endingTouches:Vector.<Touch> = e.getTouches(contextView, TouchPhase.ENDED);
			for (var k:int = 0; k < endingTouches.length; k++)
				if (endingTouches[k].id == _validTouchID)
				{
					//Interpret if its a tap
					if(e.timestamp-_timeStamp < _touchConfig["max-tap-duration"] &&
						_startTouchPos.x == endingTouches[k].getLocation(contextView).x &&
					   	_startTouchPos.y == endingTouches[k].getLocation(contextView).y)
					{
						onTap(_startTouchPos.clone());
					}

					//On-release-event for the player
					if(level.player != null)
					{
						level.player.startJump();
						_validTouchID = -1;
					}
					_startTouchPos = null;

				}
		}

		private function onTap(tapPosition:Point = null):void
		{

		}

		private function getVTouchzone(vTouchPos:Number):int
		{
			for(var i:int = _touchConfig["vTouch"].length-1 ;i>=0;i--)
			{
				if(vTouchPos>=_touchConfig["vTouch"][i])
				{
					return i;
				}
			}
			return -1;
		}
	}
}
