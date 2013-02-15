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
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.view.ScrollBackgroundView;
    import de.mediadesign.gd1011.studiof.services.JSONReader;

    import flash.events.IEventDispatcher;

    public class Level
    {
        [Inject]
        public var dispatcher:IEventDispatcher;

        private var _enemies:Vector.<Unit>;
        private var _player:Player;

        public var scrollBGs:Vector.<ScrollableBG>;
        private var JSONExtractedInformation:Object;
        public var enemyPositions:Vector.<int>;

        public function Level()
        {   enemyPositions = new Vector.<int>;
            _enemies = new Vector.<Unit>();
            scrollBGs = new Vector.<ScrollableBG>();
            JSONExtractedInformation = JSONReader.read("enemy")["ENEMY"];
            for (var index:int = 0; index<100;index++) {
                if (JSONExtractedInformation[index] != null) {
                    enemyPositions.push(JSONExtractedInformation[index]);
                }
            }
            for (var index2:int = 0; index2<enemyPositions.length; index2++) {
                addEnemy(new Unit(1, Math.round(Math.random() * 5), -300, enemyPositions[index2], this, false));
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
                if (_enemies[index] == value) {
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
            if (value != null) {
                _player = value;
            }
        }

        public function removePlayer():void
        {
            _player = null;
        }

        public function register(unit:Unit):void
        {
            var registerUnitEvent:GameEvent = new GameEvent(GameConsts.REGISTER_UNIT, GameConsts.REGISTER_UNIT, unit);
            dispatcher.dispatchEvent(registerUnitEvent);
        }

        public function initScrollBG(bgScroll:ScrollableBG):void
        {
            var registerBGEvent:GameEvent = new GameEvent(GameConsts.IMPL_BG, GameConsts.IMPL_BG, bgScroll);
            dispatcher.dispatchEvent(registerBGEvent);
        }

        public function collisionDetection():void
        {   var ab:GameEvent = new GameEvent(ViewConsts.UPDATE_LIFEPOINTS, GameConsts.ADD_SPRITE_TO_GAME, player.healthPoints);
            dispatcher.dispatchEvent(ab);

            for (var index:int =  0; index<enemies.length; index++) {
                for (var index2:int = 0; index2<enemies[index].ammunition.length; index2++) {
                    if (player.healthPoints>0 && (player.observePlatform(enemies[index].ammunition[index2].position.y)== player.currentPlatform) && (enemies[index].ammunition[index2].position.x == player.position.x ||  (enemies[index].ammunition[index2].position.x>player.position.x && enemies[index].ammunition[index2].position.x-30<player.position.x))) {
                        enemies[index].ammunition[index2].healthPoints -= 1;
                        player.healthPoints -= 1;
                    }
                }
            }
            for (var index3:int = 0; index3<player.ammunition.length; index3++) {
                for (var index4:int = 0; index4<enemies.length; index4++) {
                    if (       player.healthPoints>0
                            && enemies[index4].healthPoints>0
                            && (player.ammunition[index3].position.x < GameConsts.STAGE_WIDTH &&  player.observePlatform(enemies[index4].position.y)== player.observePlatform(player.ammunition[index3].position.y))
                            && (player.ammunition[index3].position.x == enemies[index4].position.x
                            || (player.ammunition[index3].position.x<enemies[index4].position.x && player.ammunition[index3].position.x+30>enemies[index4].position.x)))
                    {
                        enemies[index4].healthPoints -= 1;
                        player.ammunition[index3].healthPoints -= 1;
                    }
                }
            }
        }

        public function deleteDead():void
        {

        }


    }
}

