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
    import de.mediadesign.gd1011.studiof.events.GameEvent;

    import flash.events.IEventDispatcher;

    public class Level
    {
        [Inject]
        public var dispatcher:IEventDispatcher;

        private var _enemies:Vector.<Unit>;
        private var _player:Player;

        public function Level()
        {
            _enemies = new Vector.<Unit>();
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
            var unitIndex:int = -1;
            for (var index:int=0; index<_enemies.length; index++)
            {
                if (_enemies[index] == value) {
                    unitIndex = index;
                }
            }
            if (unitIndex == -1) {
                trace("removeEnemy in Level could not find the Unit. Unit was not removed.");
            } else {
                var a:Array = new Array();
                a[0] = _enemies.slice(0, unitIndex);
                a[1] = _enemies.slice(unitIndex+1, _enemies.length)
                _enemies = null;
                _enemies = new Vector.<Unit>();
                for (var i:int = 0; i<a[0].length; i++) {
                    _enemies.push(a[0][i]);
                }
                for (var ii:int = 0; ii<a[1].length; ii++) {
                    _enemies.push(a[1][ii]);
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

    }
}

