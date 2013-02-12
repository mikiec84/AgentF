/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:56
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    public class Level
    {
        private var _enemies:Vector.<Unit>;
        private var _player:Player;

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
                    _enemies.slice(index, 1)
                }
            }
        }

        public function get player():Player
        {
            return _player;
        }

        public function set player(value:Player):void
        {
            if (value != null) {
                _player = value;
            }
        }

        public function removePlayer():void
        {
            _player = null;
        }
    }
}

