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

    import flash.events.IEventDispatcher;

    public class LevelProcess implements IProcess
    {
        [Inject]
        public var dispatcher:IEventDispatcher;

        [Inject]
        public var lvlConfig:LevelConfiguration;

        private var _running:Boolean;
        private var _enemies:Vector.<Unit>;
        private var _player:Player;
        private var _fortFox:FortFoxBoss;
        private var _nautilus:NautilusBoss;
        private var _currentLevel:int = 1;

        private var JSONExtractedInformation:Object;

        private var _bgLayer01:BGScroller;
        private var _bgLayer02:BGScroller;
        private var _bgLayer03:BGScroller;

        private var _scrollLevel:Boolean = true;

        public var enemyPositions:Vector.<int>;
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
            if (enemies.length != 0)
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
            }
            // new level
            if (fortFox.healthPoints <= 0 && fortFox.initialized)
            {
                closeCurrentLevel();
                _currentLevel+=1;
                newLevel(_currentLevel);
                stopAllUnits();
            }
            //Boss Spawn
            else if (enemies.length == 0)
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
            else if (enemies.length == 0)
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
            enemyPositions = new Vector.<int>;
            _enemies = new Vector.<Unit>();

            _bgLayer01 = new BGScroller("layer01",dispatcher);
            _bgLayer02 = new BGScroller("layer02",dispatcher);
            _bgLayer03 = new BGScroller("layer03",dispatcher);


            for (var index:int = 0; index<lvlConfig.getEnemySequence(0, currentLevel-1).length; index++) //JSONExtractedInformation["enemyCount"]
            {
                enemyPositions.push(GameConsts.STAGE_WIDTH+((1+index)*JSONExtractedInformation["enemyRate"]));
            }
            //////////// CHEAT ///////////////
            if (onlyThreeMobs) {
                while(enemyPositions.length > 3)
                {
                    var a:int = enemyPositions.pop();
                }
                trace("ENEMY POSITION LENGTH: "+enemyPositions.length);
            }
            //////////////////////////////////
            for (var index2:int = 0; index2<enemyPositions.length; index2++)
            {
                if (lvlConfig.getEnemySequence(0,0)[index2] != 6)
                {
                    addEnemy(new Unit(1, lvlConfig.getEnemySequence(0,0)[index2], -300, enemyPositions[index2], this, false, index2.toString()));
                    if (enemies[enemies.length-1].currentPlatform == 2)
                    {
                        enemies[enemies.length-1].healthPoints = 3;
                    }
                }
            }
        }


        // wird vlt. nicht benötigt
        public function closeCurrentLevel():void
        {
            enemyPositions.splice(0, enemyPositions.length-1);
            _enemies.splice(0, _enemies.length-1);
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

        public function addEnemy(value:Unit):void
        {
            _enemies.push(value);
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
            for (var index:int = 0; index<enemies.length; index++)
            {
                enemies[index].stop();
                for (var index2:int = 0; index2<enemies[index].ammunition.length; index2++)
                {
                    enemies[index].ammunition[index2].stop();
                }
            }
            player.stop();
            for (var index3:int = 0;index3<player.ammunition.length; index3++)
            {
                player.ammunition[index3].stop();
            }
            if (fortFox.initialized || fortFox.moveLeftRunning)
            {
                fortFox.stop();
                for (var index4:int = 0; index4<fortFox.ammunition.length; index4++)
                {
                    fortFox.ammunition[index4].stop();
                }
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
                for (var index2:int = 0; index2<enemies[index].ammunition.length; index2++)
                {
                    enemies[index].ammunition[index2].resume();
                }
            }
            player.resume();
            for (var index3:int = 0;index3<player.ammunition.length; index3++)
            {
                player.ammunition[index3].resume();
            }
            if (fortFox.initialized || fortFox.moveLeftRunning)
            {
                fortFox.resume();
                for (var index4:int = 0; index4<fortFox.ammunition.length; index4++)
                {
                    fortFox.ammunition[index4].resume();
                }
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

        public function register(unit:Unit):void
        {
            var registerUnitEvent:GameEvent = new GameEvent(GameConsts.REGISTER_UNIT, unit);
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
    }
}

