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

        private var _levelLength:int;
        private var _enemyCount:int;
        private var _currentLvl:int;


        public function Level()
        {


        }

        public function get levelLength():int {
            return _levelLength;
        }

        public function set levelLength(value:int):void {
            _levelLength = value;
        }

        public function get enemyCount():int {
            return _enemyCount;
        }

        public function set enemyCount(value:int):void {
            _enemyCount = value;
        }

        public function get currentLvl():int {
            return _currentLvl;
        }

        public function set currentLvl(value:int):void {
            _currentLvl = value;
        }

        public function get enemies():Vector.<Unit> {
            return _enemies;
        }

        public function set enemies(value:Vector.<Unit>):void {
            _enemies = value;
        }
    }
}

