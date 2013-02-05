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
    import de.mediadesign.gd1011.studiof.model.components.Movement;
    import de.mediadesign.gd1011.studiof.model.components.Weapon;
    import de.mediadesign.gd1011.studiof.model.components.Weapon;

    public class UnitManager
    {
        private var enemies:Vector.<Unit>;
        private var player:Unit;

        public function addEnemy(platform:uint, healthPoints:int,  weapon:Weapon, movement:Movement):void
        {
            var enemy:Unit = new Unit(platform, healthPoints, weapon, movement);
            enemies.push(enemy)
        }

        public function addPlayer(platform:uint, healthPoints:int, weapon:Weapon, movement:Movement):Unit
        {
            var player:Unit = new Unit(platform,  healthPoints, weapon, movement);
            return player;
        }
    }
}
