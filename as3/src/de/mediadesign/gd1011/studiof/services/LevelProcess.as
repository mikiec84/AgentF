/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:56
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.*;
    import de.mediadesign.gd1011.studiof.model.components.EnemyInitPositioning;
    import de.mediadesign.gd1011.studiof.view.EnemyView;

    import flash.events.IEventDispatcher;
    import flash.utils.getDefinitionByName;

    import starling.display.Sprite;
    import starling.utils.AssetManager;

    public class LevelProcess implements IProcess
    {
        [Inject]
        public var dispatcher:IEventDispatcher;

        [Inject]
        public var lvlConfig:LevelConfiguration;

        [Inject]
        public var moveProcess:MoveProcess;

        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var sounds:Sounds;

        [Inject]
        public var assets:AssetManager;

        [Inject]
        public var score:Score;

        [Inject]
        public var fortFox:FortFox;

        private var _running:Boolean = false;
        private var _enemies:Vector.<Unit>;
        private var _enemyBullets:Vector.<Unit>;
        private var _player:Player;
        private var _boss:IEndboss;
        private var _currentLevel:int = 0;
        public var currentScore:int = 0;

        private var _enemyConfig:Object;
        private var _bossConfig:Object;

        private var _bgLayer01:BGScroller;
        private var _bgLayer02:BGScroller;


        private var allUnitsStopped:Boolean = false;
        private var _scrollLevel:Boolean = true;

        private var fortFoxStarted:Boolean = false;

        public var currentXKoord:int = GameConsts.STAGE_WIDTH;
        public var enemyPositions:Vector.<EnemyInitPositioning>;
		private var _enemySequence:Array;

        ///CHEATS
        public var onlyThreeMobs:Boolean = false;
        public var bossHaveLowLife:Boolean = false;
        /////////

        private var bossEnemiesSpawnCounter:int = 0;

        public function LevelProcess()
        {
            _enemyConfig = JSONReader.read("enemy")["ENEMY"];
        }

		public function newLevel(currentLevel:int):void
		{
			fortFoxStarted = false;
			if (currentLevel == 0)
			{
				if (assets.getTexture("TileSystemLevel2_1") != null)
				{
					var deleteLevelEvent:GameEvent = new GameEvent(ViewConsts.DELETE_LEVEL, currentLevel+1);
					dispatcher.dispatchEvent(deleteLevelEvent);
				}
				var loadLevelEvent:GameEvent = new GameEvent(ViewConsts.LOAD_LEVEL, currentLevel);
				dispatcher.dispatchEvent(loadLevelEvent);
			}
			else if (currentLevel == 1)
			{
				if (assets.getTexture("TileSystemLevel1_1") != null)
				{
					var deleteLevelEvent:GameEvent = new GameEvent(ViewConsts.DELETE_LEVEL, currentLevel-1);
					dispatcher.dispatchEvent(deleteLevelEvent);
				}
				var loadLevelEvent:GameEvent = new GameEvent(ViewConsts.LOAD_LEVEL, currentLevel);
				dispatcher.dispatchEvent(loadLevelEvent);
			}
			initializeLevel();
		}

		public function initializeLevel():void
		{

			setPlayer(new Player(this));
			moveProcess.addEntity(player);

			var playerView:EnemyView = new EnemyView(ViewConsts.PLAYER, ViewConsts.PLAYER);
			renderProcess.registerRenderable(new Renderable(player.position, playerView));

			var addSpriteToGameEvent:GameEvent = new GameEvent(ViewConsts.ADD_SPRITE_TO_GAME, playerView);
			dispatcher.dispatchEvent(addSpriteToGameEvent);
			_bossConfig = JSONReader.read("level/level")[0][currentLevel]["endboss"];
			boss = new (getDefinitionByName("de.mediadesign.gd1011.studiof.model."+_bossConfig["classname"]) as Class)(this, _bossConfig);

			enemyPositions = new Vector.<EnemyInitPositioning>;
			_enemies = new Vector.<Unit>();
			_enemyBullets = new Vector.<Unit>();
			currentXKoord = GameConsts.STAGE_WIDTH;

			_bgLayer01 = new BGScroller("layer01",dispatcher, currentLevel, false);
			_bgLayer02 = new BGScroller("layer02",dispatcher, currentLevel);

			sounds.setBGSound(currentLevel,"intro",true);
			sounds.setBGSound(currentLevel,"bg-loop");

			_enemySequence =  lvlConfig.getEnemySequence(0, currentLevel);


			for (var index:int = 0; index<_enemySequence.length; index++)
			{
				enemyPositions.push(new EnemyInitPositioning(false, GameConsts.STAGE_WIDTH+((1+index)*_enemyConfig["enemyRate"])));
			}
			//////////// CHEAT ///////////////
			if (onlyThreeMobs)
			{
				while(enemyPositions.length > 10)
				{
					enemyPositions.pop();
				}
				trace("ENEMY POSITION LENGTH: "+enemyPositions.length);
			}
			//////////////////////////////////
			var addWaterEvent:GameEvent = new GameEvent(ViewConsts.ADD_WATER_TO_GAME);
			dispatcher.dispatchEvent(addWaterEvent);
			start();
		}

        public function update(time:Number):void
        {
			if(!_running || player == null)
			    return;

            deleteOffscreenUnits();
            //shootBullets
            if (_player.shootNow())
                _player.shootBullet(time);

            boss.update(time);

            for (var index:int = 0; index<enemies.length; index++)
                enemies[index].shootBullet(time);

            _bgLayer01.update();
            _bgLayer02.update();

            updateLP();
            checkLevelState();
            checkStates();
            enemySpawn(time);
        }

        private function enemySpawn(time:Number):void
        {
            if (!allUnitsStopped)
            {
                currentXKoord += 300*time;
            }

            for (var index2:int = 0; index2<enemyPositions.length; index2++)
            {
                if ((_enemySequence[index2] != 6 || boss.initialized)
                        && enemyPositions[index2].xPos < currentXKoord
                        && !enemyPositions[index2].spawned)
                {
                    enemyPositions[index2].spawned = true;
                    createAndShowEnemy(index2);
                }
            }

            if (enemies.length > 0 && enemies[enemies.length-1].bossEnemy)
            {
                for (var i:int = 0; i<enemies.length; i++)
                {
                    if (enemies[i].bossEnemy && i+1 < enemies.length && enemies[i+1].position.x-enemies[i].position.x < 500)
                    {
                        deleteUnit(enemies[i+1]);
                        enemies.splice(i+1, 1);
                    }
                }
            }

            if (enemyPositions.length == 0 || boss.initialized && (enemyPositions[enemyPositions.length-1].spawned))
            {
                bossEnemiesSpawnCounter = currentXKoord+_bossConfig["enemyRate"];
                enemyPositions.push(new EnemyInitPositioning(false, bossEnemiesSpawnCounter));
            }
        }

        public function deleteOffscreenUnits():void
        {
            for (var index:int = 0; index<enemyBullets.length; index++)
            {
                if (enemyBullets[index].position.x < -50 || enemyBullets[index].position.y > GameConsts.STAGE_HEIGHT+200)
                {
                    deleteUnit(enemyBullets[index]);
                    enemyBullets.splice(index,  1);
                }
            }
            for (var index2:int = 0; index2<enemies.length; index2++)
            {
                if (enemies[index2].position.x < - 250 || enemies[index2].position.y > GameConsts.STAGE_HEIGHT+200)
                {
                    deleteUnit(enemies[index2]);
                    enemies.splice(index2,  1);
                }
            }
            for (var index3:int = 0; index3<player.ammunition.length; index3++)
            {
                if (player.ammunition[index3].position.x > GameConsts.STAGE_WIDTH  || player.ammunition[index3].position.y > GameConsts.STAGE_HEIGHT+200)
                {
                    deleteUnit(player.ammunition[index3]);
                    player.ammunition.splice(index3,  1);
                }
            }
            if (boss != null && boss.initialized && boss is NautilusBoss)
            {
                for (var index4:int = 0; index4<boss.ammunition.length; index4++)
                {
                    if (boss.ammunition[index4].position.x < 0 || boss.ammunition[index4].position.y > GameConsts.STAGE_HEIGHT+200)
                    {
                        deleteUnit(boss.ammunition[index4]);
                        boss.ammunition.splice(index4, 1);
                    }
                }
            }
        }

        private function shouldBossSpawn():Boolean
        {
			for(var i:int = enemyPositions.length-1; i >= 0; i--)
				if(_enemySequence[i]!=6)
            	return enemyPositions[i].spawned;
			return true;
        }

        private function createAndShowEnemy(index:int):void
        {   // enemies vector
            if (boss != null && boss.initialized)
            {
                _enemies.push(new Unit(1, -1, (-1)*_enemyConfig["enemySpeed"], GameConsts.STAGE_WIDTH+1452, this, false, true, index.toString()));
            }
            else
            {
                _enemies.push(new Unit(1, _enemySequence[index], (-1)*_enemyConfig["enemySpeed"], GameConsts.STAGE_WIDTH+1452, this, false, false, index.toString()));
            }
            // moveProcess
            moveProcess.addEntity(_enemies[_enemies.length-1]);
            // texture
            if (_enemies[_enemies.length-1].observePlatform(_enemies[_enemies.length-1].position.y) < 2)
                var enemyView:EnemyView = new EnemyView(ViewConsts.FLYING_ENEMY, _enemies[_enemies.length-1].ID);
            if (_enemies[_enemies.length-1].observePlatform(_enemies[_enemies.length-1].position.y) == 2)
                var enemyView:EnemyView = new EnemyView(ViewConsts.FLOATING_ENEMY, _enemies[_enemies.length-1].ID);
            if (_enemies[_enemies.length-1].observePlatform(_enemies[_enemies.length-1].position.y) > 2)
                var enemyView:EnemyView = new EnemyView(ViewConsts.UNDERWATER_ENEMY, _enemies[_enemies.length-1].ID);
            // renderProcess
            renderProcess.registerRenderable(new Renderable(_enemies[_enemies.length-1].position, enemyView));
            var addEnemySpriteToGameEvent:GameEvent = new GameEvent(ViewConsts.ADD_SPRITE_TO_GAME, enemyView);
            dispatcher.dispatchEvent(addEnemySpriteToGameEvent);

        }

        public function updateLP():void
        {
            var updateLifePointEvent:GameEvent = new GameEvent(ViewConsts.UPDATE_LIFEPOINTS, player.healthPoints);
            dispatcher.dispatchEvent(updateLifePointEvent);
        }

        public function checkLevelState():void
        {
            //Loose
            if (player.healthPoints<1)
            {
                var gameOverEvent:GameEvent = new GameEvent(ViewConsts.SHOW_GAMEOVER, false);
                dispatcher.dispatchEvent(gameOverEvent);
				stop();
            }
            // new level
            if (boss.healthPoints <= 0 && boss.initialized)
            {
				sounds.setBGSound(currentLevel,"outro",true, false);
				_currentLevel+=1;
				var showHighScoreEvent:GameEvent = new GameEvent(ViewConsts.SHOW_HIGHSCORE, currentScore);
				dispatcher.dispatchEvent(showHighScoreEvent);
				clearLevel();

            }
            //Boss Spawn
            else if (enemies.length == 0 && shouldBossSpawn())
            {
                if(!boss.initialized)
                {
                    if (currentLevel == 0)
                    {
                        if (fortFox.position.x <= GameConsts.STAGE_WIDTH - 885)
                        {
                            fortFox.position.x = GameConsts.STAGE_WIDTH - 890;
                            fortFox.stop();
                            spawnBoss();
                            stopScrollLevel();
                            var addFortEvent:GameEvent = new GameEvent(ViewConsts.CREATE_FORTBG);
                            dispatcher.dispatchEvent(addFortEvent);
                            var removeFortEvent:GameEvent = new GameEvent(GameConsts.DELETE_UNIT, fortFox);
                            dispatcher.dispatchEvent(removeFortEvent);
                        }
                        if (!fortFoxStarted)
                        {
                            fortFoxStarted = true;
                            var registerFortEvent:GameEvent = new GameEvent(GameConsts.REGISTER_FORT);
                            dispatcher.dispatchEvent(registerFortEvent);
                        }
                    }
                    else
                    {
                        spawnBoss();
                    }
                }
            }
        }
        // change states of different Units
        private function checkStates():void
        {
            for (var i:int = 0; i < enemies.length; i++)
            {
                if (enemies[i].currentPlatform < 2)
                {
                    if (enemies[i].lastState != enemies[i].state)
                    {
                        var changeStateEvent:GameEvent = new GameEvent(GameConsts.CHANGE_STATE, enemies[i]);
                        dispatcher.dispatchEvent(changeStateEvent);
                    }
                    enemies[i].lastState = enemies[i].state
                }
            }
            if (boss.initialized && boss is NautilusBoss)
            {
                if ((boss as NautilusBoss).lastState != (boss as NautilusBoss).state)
                {
                    var changeStateEvent:GameEvent = new GameEvent(GameConsts.CHANGE_STATE, boss);
                    dispatcher.dispatchEvent(changeStateEvent);
                }
                (boss as NautilusBoss).lastState = (boss as NautilusBoss).state;
            }
            if (player.lastState != player.state)
            {
                var changeStateEvent:GameEvent = new GameEvent(GameConsts.CHANGE_STATE, player);
                dispatcher.dispatchEvent(changeStateEvent);
                if (player.state == GameConsts.IDLE)
                {
                    var splashEvent:GameEvent = new GameEvent(ViewConsts.SPLASH, player);
                    dispatcher.dispatchEvent(splashEvent);
                }
            }
            player.lastState = player.state;
        }

        public function clearLevel():void
        {
			stop();
            currentScore = 0;
			_bgLayer01.dispose();
			_bgLayer02.dispose();
            deleteUnit(player);
            deleteEndboss(boss);

            for (var i:int = 0; i<enemies.length; i++)
            {
                if (enemies[i] is Unit)
                {
                    deleteUnit(enemies[i]);
                }
            }
            for (var i:int = 0; i<enemyBullets.length; i++)
            {
                if (enemyBullets[i] is Unit)
                    deleteUnit(enemyBullets[i]);
            }
            while(enemyPositions.length > 0)
            {
                enemyPositions.pop();
            }
        }

        public function deleteEndboss(unit:IEndboss):void
        {
            var view:Sprite = null;

            // delete Renderable in Vector
            for (var i:int = new int(); i < renderProcess.targets.length; i++)
            {
                if (unit.position == renderProcess.targets[i].position)
                {
                    view = renderProcess.targets[i].view;
                    renderProcess.deleteRenderableByID(i);
                }
            }
            // delete Movable in Vector
            for (var i:int = 0; i < moveProcess.targets.length; i++)
            {
                if (moveProcess.targets[i] is Unit && unit.position == (moveProcess.targets[i] as Unit).position)
                {
                    moveProcess.removeEntity(i);
                }
            }
            if (view != null)
            {
                var removeFromGameEvent:GameEvent = new GameEvent(ViewConsts.REMOVE_SPRITE_FROM_GAME, view);
                dispatcher.dispatchEvent(removeFromGameEvent);
            }
        }

        public function spawnBoss():void
        {
			if (!boss.initialized && !boss.moveLeftRunning)
			{
                boss.start();
				sounds.setBGSound(currentLevel,"boss-intro");
				sounds.setBGSound(currentLevel,"boss-loop1");
			}
        }

        public function get enemies():Vector.<Unit>
        {
            return _enemies;
        }

        public function get player():Player
        {
            return _player;
        }

        public function setPlayer(value:Player):void
        {
            if (value != null)
            {
                _player = value;
            }
        }

        public function stopAllUnits():void
        {
            for (var index:int = 0; index < enemies.length; index++)
            {
                enemies[index].stop();
            }
            for (var index2:int = 0; index2 < _enemyBullets.length; index2++)
            {
                _enemyBullets[index2].stop();
            }
            player.stop();
            for (var index3:int = 0;index3<player.ammunition.length; index3++)
            {
                player.ammunition[index3].stop();
            }
            if (boss.initialized || boss.moveLeftRunning)
            {
                boss.stop();
            }
            allUnitsStopped = true;
        }

        public function resumeAllUnits():void
        {
            allUnitsStopped = false;
            for (var index:int = 0; index<enemies.length; index++)
            {
                enemies[index].resume();
            }
            for (var index2:int = 0; index2 < _enemyBullets.length; index2++)
            {
                _enemyBullets[index2].resume();
            }
            player.resume();
            for (var index3:int = 0;index3<player.ammunition.length; index3++)
            {
                player.ammunition[index3].resume();
            }
            if (boss.initialized || boss.moveLeftRunning)
            {
                boss.resume();
            }
        }

        public function register(bullet:Unit, shootingUnit:Unit):void
        {
			//sounds.play("shot");
            var infos:Array = new Array();
            infos.push(bullet);
            infos.push(shootingUnit);
            var registerUnitEvent:GameEvent = new GameEvent(GameConsts.REGISTER_UNIT, infos);
            dispatcher.dispatchEvent(registerUnitEvent);
        }

        public function deleteUnit(unit:Unit):void
        {
            var deleteUnitEvent:GameEvent = new GameEvent(GameConsts.DELETE_UNIT, unit);
            dispatcher.dispatchEvent(deleteUnitEvent);
        }

        public function stopScrollLevel():void
        {
            _scrollLevel = false;
			_bgLayer01.stopScrolling();
            _bgLayer02.stopScrolling();
        }

		public function resumeScrollLevel():void
		{
			_scrollLevel = true;
			_bgLayer01.resumeScrolling();
			_bgLayer02.resumeScrolling();
		}


        public function get boss():IEndboss
        {
            return _boss;
        }

        public function set boss(value:IEndboss):void
        {
            _boss = value;
        }

        public function get currentLevel():int
        {
            return _currentLevel;
        }

        public function set currentLevel(value:int):void
        {
            _currentLevel = value;
        }

        public function start():void
        {
            _running = true;
			GameJuggler.start();
			resumeAllUnits();
			resumeScrollLevel();
        }

        public function stop():void
        {
            _running = false;
			GameJuggler.stop();
			stopAllUnits();
			stopScrollLevel();
        }

        public function get enemyBullets():Vector.<Unit>
        {
            return _enemyBullets;
        }

        public function set enemyBullets(value:Vector.<Unit>):void
        {
            _enemyBullets = value;
        }
    }
}

