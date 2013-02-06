/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:56
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.model.components.Currentlevel;

    public class Level
    {
        private var _enemies:Vector.<Unit>;
        private var _currentLevel:Currentlevel;


        public function Level()
        {   _currentLevel = new Currentlevel("default");


        }

        public function get enemies():Vector.<Unit> {
            return _enemies;
        }

        public function set enemies(value:Vector.<Unit>):void {
            _enemies = value;
        }

        public function get currentLevel():Currentlevel {
            return _currentLevel;
        }

        public function set currentLevel(value:Currentlevel):void {
            _currentLevel = value;
        }
    }
}

