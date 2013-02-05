/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 14:39
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.events
{
    import de.mediadesign.gd1011.studiof.model.components.Movement;
    import de.mediadesign.gd1011.studiof.model.components.Weapon;

    import starling.events.Event;

    public class InitUnitEvent extends Event
    {
        private var platform:uint;
        private var healthPoints:int;
        private var weapon:Weapon;
        private var movement:Movement;

        public function InitUnitEvent(type:String, platform:uint = 2, healthPoints:int = 1, weapon:Weapon = null, movement:Movement = null)
        {
            super(type, false, false);
            this.platform = platform;
            this.healthPoints = healthPoints;
            this.weapon = weapon;
            this.movement = movement;
        }
    }
}
