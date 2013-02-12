/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:56
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;
    import de.mediadesign.gd1011.studiof.model.components.VelocityComponent;

    public class Unit implements IMovable
    {
        public var healthPoints:int;
        public var currentPlatform:int;
        public var position:PositionComponent;
        public var velocity:VelocityComponent;
        public var weapon:String;


        public function Unit(healthpoints:int, startingPlatform:int)
        {   weapon = "default";
            currentPlatform = startingPlatform;
            healthPoints = healthpoints;
            position = new PositionComponent();
            velocity = new VelocityComponent();
        }

        public function move(time:Number):void {
            if (assertCorrectInitialization()) {
                position.x += velocity.velocityX*time;
            } else trace("----------Function Move failed, because Unit not correctly initialized: "+position.x+","+position.y+","+velocity+","+currentPlatform+","+this);
        }

        public function assertCorrectInitialization():Boolean
        {
            if(position == null) return false;
            if(velocity == null) return false;
            if(healthPoints < 1) return false;
            return !(currentPlatform > 5 || currentPlatform < 0);
        }
    }
}
