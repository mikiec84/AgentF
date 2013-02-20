/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:56
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.view.ScrollBackgroundView;
    import de.mediadesign.gd1011.studiof.services.JSONReader;

    import flash.events.IEventDispatcher;

    public class Level
    {
        [Inject]
        public var dispatcher:IEventDispatcher;

		[Inject]
		public var lvlConfig:LevelConfiguration;

        private var _enemies:Vector.<Unit>;
        private var _player:Player;
        private var _fortFox:FortFoxBoss;

        public var scrollBGs:Vector.<ScrollableBG>;

        private var JSONExtractedInformation:Object;

        public var enemyPositions:Vector.<int>;
        public var collisionTolerance:int;              // Wie weit die bullet von der Unit entfernt sein darf um immernoch als treffer zu zählen

        public function Level()
        {
			enemyPositions = new Vector.<int>;
            _enemies = new Vector.<Unit>();
            scrollBGs = new Vector.<ScrollableBG>();

            JSONExtractedInformation = JSONReader.read("enemy")["ENEMY"];
            collisionTolerance = JSONExtractedInformation["collisionTolerance"];
        }

		[PostConstruct]
		public function onCreated():void
		{

            for (var index:int = 0; index<lvlConfig.getEnemySequence(0,0).length; index++) //JSONExtractedInformation["enemyCount"]
            {
                enemyPositions.push(GameConsts.STAGE_WIDTH+((1+index)*JSONExtractedInformation["enemyRate"]));
            }
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

        public function removePlayer():void
        {
            _player = null;
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

        public function initScrollBG(bgScroll:ScrollableBG):void
        {
            var registerBGEvent:GameEvent = new GameEvent(GameConsts.IMPL_BG, bgScroll);
            dispatcher.dispatchEvent(registerBGEvent);
        }


        public function get fortFox():FortFoxBoss
        {
            return _fortFox;
        }

        public function set fortFox(value:FortFoxBoss):void
        {
            _fortFox = value;
        }
    }
}

