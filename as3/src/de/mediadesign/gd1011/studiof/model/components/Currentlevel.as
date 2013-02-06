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
        //und weitere leveleigenschaften

        public function Currentlevel(initMode:String = null) {
            switch (initMode){
                case "default":
                    _currentLevel       = 0;
                    _currentLevelLength = 0;
                    _enemyCount         = 0;
                    break;
                case "Level1":
                    _currentLevel       = 1;
                    _currentLevelLength = 7;
                    _enemyCount         = 20;
                    break;
                case null:
                    trace("initMode Parameter in CurrentLevel component = null.");
                    break;
            }
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
