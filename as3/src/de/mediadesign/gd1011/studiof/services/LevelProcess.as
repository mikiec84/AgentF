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

        private var _running:Boolean = true;
        private var _enemies:Vector.<Unit>;
        private var _enemieBullets:Vector.<Unit>;
        private var _player:Player;
        private var _fortFox:FortFoxBoss;
        private var _nautilus:NautilusBoss;
        private var _currentLevel:int = 1;

        private var JSONExtractedInformation:Object;

        private var _bgLayer01:BGScroller;
        private var _bgLayer02:BGScroller;
        private var _bgLayer03:BGScroller;

        private var _scrollLevel:Boolean = true;

        public var currentXKoord:int = GameConsts.STAGE_WIDTH;
        public var enemyPositions:Vector.<EnemyInitPositioning>;
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
            newLevel(1);
        }

        public function update(time:Number):void
        {
			if(!_running)
			return;
            if(player == null)
                return;

            //shootBullets
            if (_player.shootNow())
                _player.shootBullet(time);

            if (nautilus.initialized)
                nautilus.shootBullet(time);

            for (var index:int = 0; index<enemies.length; index++)
                enemies[index].shootBullet(time);

            _bgLayer01.update();
            _bgLayer02.update();
            _bgLayer03.update();

            updateLP();
            checkStatus();

            currentXKoord += 300*time;

            for (var index2:int = 0; index2<enemyPositions.length; index2++)
            {
                if (lvlConfig.getEnemySequence(0,0)[index2] != 6 && enemyPositions[index2].xPos < currentXKoord && !enemyPositions[index2].spawned)
                {
                    enemyPositions[index2].spawned = true;
                    createAndShowEnemy(index2);
                }
            }
        }

        private function shouldBossSpawn():Boolean
        {   var a:int = -1;
            for (var index:int = 0; index<lvlConfig.getEnemySequence(0,0).length; index++) {
                if (lvlConfig.getEnemySequence(0,0)[index] != 6) {
                    a = index;
                }
            }
            return enemyPositions[a].spawned;
        }

        private function createAndShowEnemy(index:int):void
        {   // enemies vector
            _enemies.push(new Unit(1, lvlConfig.getEnemySequence(0,0)[index], -300, enemyPositions[index].xPos, this, false, index.toString()));
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
            // End of Level 1, start Boss Level 1
            /*if (enemies.length != 0)
            {
                if (player.healthPoints > 0
                        && (enemies[enemies.length-1].healthPoints < 1
                        || enemies[enemies.length - 1].position.x < 0))
                {
                    if(!fortFox.initialized && !fortFox.moveLeftRunning)
                    {
                        stopScrollLevel();
                        spawnBoss();
                    }
                }
            }*/
            // new level
            if (fortFox.healthPoints <= 0 && fortFox.initialized)
            {
                closeCurrentLevel();
                _currentLevel+=1;
                newLevel(_currentLevel);
                stopAllUnits();
            }
            //Boss Spawn
            else if (enemies.length == 0 && shouldBossSpawn())
            {
                if(!fortFox.initialized && !fortFox.moveLeftRunning)
                {
                    stopScrollLevel();
                    spawnBoss();
                }
            }
            // Win
            if (nautilus.healthPoints <= 0 && nautilus.initialized)
            {
                currentLevel+=1;
                var gameWonEvent2:GameEvent = new GameEvent(ViewConsts.SHOW_GAMEOVER, true);
                dispatcher.dispatchEvent(gameWonEvent2);
                stopAllUnits();
            }

            //Boss Spawn
            else if (enemies.length == 0 && shouldBossSpawn())
            {
                if(!nautilus.initialized && !nautilus.moveLeftRunning)
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

            _bgLayer01 = new BGScroller("layer01",dispatcher, currentLevel, false);
            _bgLayer02 = new BGScroller("layer02",dispatcher, currentLevel);
            _bgLayer03 = new BGScroller("layer03",dispatcher, currentLevel);


            for (var index:int = 0; index<lvlConfig.getEnemySequence(0, currentLevel-1).length; index++) //JSONExtractedInformation["enemyCount"]
            {
                enemyPositions.push(new EnemyInitPositioning(false, GameConsts.STAGE_WIDTH+((1+index)*JSONExtractedInformation["enemyRate"])));
            }
            //////////// CHEAT ///////////////
            if (onlyThreeMobs) {
                while(enemyPositions.length > 3)
                {
                    var a:EnemyInitPositioning = enemyPositions.pop();
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
            var JSONExtract = JSONReader.read("enemy")["BOSS_SPAWN"];
            if (JSONExtract[_currentLevel] != null)
            { //trace("JSONExtract = JSONReader.read('enemy')['BOSS_SPAWN'], JSONExtract[currentLevel]: "+JSONExtract[currentLevel]);
                if (JSONExtract[_currentLevel] == "Fort_Fox") {
                    if (!fortFox.initialized && !fortFox.moveLeftRunning) {
                        fortFox.start();
                    }
                }
                else
                if (JSONExtract[_currentLevel] == "Nautilus")
                {
                    if (!nautilus.initialized && !nautilus.moveLeftRunning) {
                        nautilus.start();
                    }
                }
            }
            else trace("Es wird versucht ein Level Endboss zu starten, der in der JSON nicht eingetragen ist.");
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
            if (fortFox.initialized || fortFox.moveLeftRunning)
            {
                fortFox.stop();
            }
            if (nautilus.initialized || nautilus.moveLeftRunning)
            {
                nautilus.stop();
                for (var index5:int = 0; index5<nautilus.ammunition.length; index5++)
                {
                    nautilus.ammunition[index5].stop();
                }
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
            if (fortFox.initialized || fortFox.moveLeftRunning)
            {
                fortFox.resume();
            }
            if (nautilus.initialized || nautilus.moveLeftRunning)
            {
                nautilus.resume();
                for (var index5:int = 0; index5<nautilus.ammunition.length; index5++)
                {
                    nautilus.ammunition[index5].resume();
                }
            }
        }

        public function register(bullet:Unit, shootingUnit:Unit):void
        {
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
			_bgLayer03.stopScrolling();
        }


        public function get fortFox():FortFoxBoss
        {
            return _fortFox;
        }

        public function set fortFox(value:FortFoxBoss):void
        {
            _fortFox = value;
        }

        public function get nautilus():NautilusBoss
        {
            return _nautilus;
        }

        public function set nautilus(value:NautilusBoss):void
        {
            _nautilus = value;
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

