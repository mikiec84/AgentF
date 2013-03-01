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

        private var _running:Boolean = true;
        private var _enemies:Vector.<Unit>;
        private var _enemieBullets:Vector.<Unit>;
        private var _player:Player;
        private var _boss:IEndboss;
        private var _currentLevel:int = 0;

        private var JSONExtractedInformation:Object;

        private var _bgLayer01:BGScroller;
        private var _bgLayer02:BGScroller;

        private var _scrollLevel:Boolean = true;

        public var currentXKoord:int = GameConsts.STAGE_WIDTH;
        public var enemyPositions:Vector.<EnemyInitPositioning>;
		private var _enemySequence:Array;
        public var collisionTolerance:int; // Wie weit die bullet von der Unit entfernt sein darf um immernoch als treffer zu zählen

        ///CHEATS
        public var onlyThreeMobs:Boolean = false;
        public var bossHaveLowLife:Boolean = false;
        /////////

        private var lastState:String;

        public function LevelProcess()
        {
            JSONExtractedInformation = JSONReader.read("enemy")["ENEMY"];
            collisionTolerance = JSONExtractedInformation["collisionTolerance"];
        }

        [PostConstruct]
        public function onCreated():void
        {
            newLevel(_currentLevel);
        }

        public function update(time:Number):void
        {
			if(!_running)
			return;
            if(player == null)
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
            checkStatus();

            currentXKoord += 300*time;

            for (var index2:int = 0; index2<enemyPositions.length; index2++)
            {
                if (_enemySequence[index2] != 6 && enemyPositions[index2].xPos < currentXKoord && !enemyPositions[index2].spawned)
                {
                    enemyPositions[index2].spawned = true;
                    createAndShowEnemy(index2);
                }
            }
        }

        public function deleteOffscreenUnits():void
        {
            for (var index:int = 0; index<enemieBullets.length; index++)
            {
                if (enemieBullets[index].position.x < -300)
                {
                    deleteCurrentUnit(enemieBullets[index]);
                    enemieBullets.splice(index,  1);
                }
            }
            for (var index2:int = 0; index2<enemies.length; index2++)
            {
                if (enemies[index2].position.x < -300)
                {
                    deleteCurrentUnit(enemies[index2]);
                    enemies.splice(index2,  1);
                }
            }
            for (var index3:int = 0; index3<player.ammunition.length; index3++)
            {
                if (player.ammunition[index3].position.x > GameConsts.STAGE_WIDTH+300)
                {
                    deleteCurrentUnit(player.ammunition[index3]);
                    player.ammunition.splice(index3,  1);
                }
            }
        }

        private function shouldBossSpawn():Boolean
        {
			for(var i:int = enemyPositions.length-1; i>=0;i--)
				if(_enemySequence[i]!=6)
            	return enemyPositions[i].spawned;
			return true;
        }

        private function createAndShowEnemy(index:int):void
        {   // enemies vector
            _enemies.push(new Unit(1, _enemySequence[index], (-1)*JSONExtractedInformation["enemySpeed"], enemyPositions[index].xPos, this, false, index.toString()));
            // moveProcess
            moveProcess.addEntity(_enemies[_enemies.length-1]);
            // texture
            if (_enemies[_enemies.length-1].currentPlatform < 2)
                var enemyView:EnemyView = new EnemyView(ViewConsts.FLYING_ENEMY, _enemies[_enemies.length-1].ID);
            if (_enemies[_enemies.length-1].currentPlatform == 2)
                var enemyView:EnemyView = new EnemyView(ViewConsts.FLOATING_ENEMY, _enemies[_enemies.length-1].ID);
            if (_enemies[_enemies.length-1].currentPlatform > 2)
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

        public function checkStatus():void
        {
            //Lost
            if (player.healthPoints<1)
            {
                var gameOverEvent:GameEvent = new GameEvent(ViewConsts.SHOW_GAMEOVER, false);
                dispatcher.dispatchEvent(gameOverEvent);
                stopAllUnits();
            }
            // new level
            if (boss.healthPoints <= 0 && boss.initialized)
            {
                closeCurrentLevel();
                _currentLevel+=1;
                //stopAllUnits();
                newLevel(_currentLevel);
            }
            //Boss Spawn
            else if (enemies.length == 0 && shouldBossSpawn())
            {
                if(!boss.initialized)
                {
                    stopScrollLevel();
                    spawnBoss();
                }
            }

            if (lastState != player.state)
            {
                var changeStateEvent:GameEvent = new GameEvent(GameConsts.CHANGE_STATE, player.state);
                dispatcher.dispatchEvent(changeStateEvent);
            }
            lastState = player.state;
        }



		public function newLevel(currentLevel:int):void
        {
            enemyPositions = new Vector.<EnemyInitPositioning>;
            _enemies = new Vector.<Unit>();
            _enemieBullets = new Vector.<Unit>();
            currentXKoord = GameConsts.STAGE_WIDTH;

            _bgLayer01 = new BGScroller("layer01",dispatcher, currentLevel, false);
            _bgLayer02 = new BGScroller("layer02",dispatcher, currentLevel);

			sounds.setBGSound(currentLevel,"intro");
            sounds.setBGSound(currentLevel,"bg-loop");

			_enemySequence =  lvlConfig.getEnemySequence(0, currentLevel);


			for (var index:int = 0; index<_enemySequence.length; index++) //JSONExtractedInformation["enemyCount"]
            {
                enemyPositions.push(new EnemyInitPositioning(false, GameConsts.STAGE_WIDTH+((1+index)*JSONExtractedInformation["enemyRate"])));
            }
            //////////// CHEAT ///////////////
            if (onlyThreeMobs) {
                while(enemyPositions.length > 3)
                {
                    enemyPositions.pop();
                }
                trace("ENEMY POSITION LENGTH: "+enemyPositions.length);
            }
            //////////////////////////////////
        }


        // wird vlt. nicht benötigt
        public function closeCurrentLevel():void
        {
            enemyPositions.splice(0, enemyPositions.length-1);
            _enemies.splice(0, _enemies.length-1);
			this.stop();
        }

        public function spawnBoss():void
        {

			if (!boss.initialized && !boss.moveLeftRunning)
			{
				boss.start();
				sounds.setBGSound(currentLevel,"boss-intro");
				sounds.setBGSound(currentLevel,"boss-loop1");
			}
            //else trace("Es wird versucht ein Level Endboss zu starten, der in der JSON nicht eingetragen ist.");
        }

        public function get enemies():Vector.<Unit>
        {
            return _enemies;
        }

        public function removeEnemy(value:Unit):void
        {
            for (var index:int=0; index<_enemies.length; index++)
            {
                if (_enemies[index] == value)
                {
                    _enemies.splice(index, 1);
                }
            }
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
            for (var index2:int = 0; index2 < _enemieBullets.length; index2++)
            {
                _enemieBullets[index2].stop();
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
        }

        public function resumeAllUnits():void
        {
            for (var index:int = 0; index<enemies.length; index++)
            {
                enemies[index].resume();
            }
            for (var index2:int = 0; index2 < _enemieBullets.length; index2++)
            {
                _enemieBullets[index2].stop();
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

        public function deleteCurrentUnit(unit:Unit):void
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
        }

        public function stop():void
        {
            _running = false;
        }

        public function get enemieBullets():Vector.<Unit>
        {
            return _enemieBullets;
        }

        public function set enemieBullets(value:Vector.<Unit>):void
        {
            _enemieBullets = value;
        }
    }
}

