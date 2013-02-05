/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:56
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.model.components.Movement;
    import de.mediadesign.gd1011.studiof.model.components.Weapon;

    import flash.geom.Point;

    public class Unit
    {
        private var movement:Movement;
        private var weapon:Weapon;
        private var heathPoints:int;
        private var position:Point;


        public function Unit()
        {
        }
    }
}
