/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:58
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
    import de.mediadesign.gd1011.studiof.model.Unit;

    public class Rules
    {
        public static function collisionDetection(unit1:Unit, unit2:Unit):void
        {
            if (unit1.platform == unit2.platform && unit1.moveData.position.x == unit2.moveData.position.x)
            {
                unit1.healthPoints--;
                unit2.healthPoints--;
            }
        }

        public static function isDead(unit:Unit):Boolean
        {
            return (unit.healthPoints <= 0);
        }

        public static function loose(player:Unit):Boolean
        {
            return isDead(player);
        }
    }
}
