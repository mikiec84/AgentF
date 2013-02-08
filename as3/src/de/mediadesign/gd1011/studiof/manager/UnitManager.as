/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 15:10
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.manager
{
    import de.mediadesign.gd1011.studiof.model.Unit;

    public class UnitManager
    {
        private var _units:Vector.<Unit>;

        public function addEnemy(platform:uint, healthPoints:int,  weapon:String, movement:String):void
        {
//            var enemy:Unit = new Unit(platform, healthPoints, weapon, movement);
//            enemies.push(enemy)
        }

        public function addPlayer(platform:uint, healthPoints:int, weapon:String, movement:String):Unit
        {
//            var player:Unit = new Unit(platform,  healthPoints, weapon, movement);
             return null;
        }

        public function get units():Vector.<Unit> {
            return _units;
        }

        public function set units(value:Vector.<Unit>):void {
            _units = value;
        }
    }
}
