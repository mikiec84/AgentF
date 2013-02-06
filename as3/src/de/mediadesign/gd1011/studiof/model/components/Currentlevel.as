/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 06.02.13
 * Time: 11:22
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model.components {
    public class Currentlevel {

        private var _currentLevel:int;
        private var _currentLevelLength:int;
        private var _enemyCount:int;
        //und weitere besonderheiten des levels hierhin

        public function Currentlevel() {

        }

        public function get currentLevel():int {
            return _currentLevel;
        }

        public function set currentLevel(value:int):void {
            _currentLevel = value;
        }

        public function get currentLevelLength():int {
            return _currentLevelLength;
        }

        public function set currentLevelLength(value:int):void {
            _currentLevelLength = value;
        }

        public function get enemyCount():int {
            return _enemyCount;
        }

        public function set enemyCount(value:int):void {
            _enemyCount = value;
        }
    }
}
