/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 08.02.13
 * Time: 11:59
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;

    public class Moveable implements IMoveable
    {
        public var position:PositionComponent;
        public var velocity:Number;  //VELOCITY COMPONENT


        public function Moveable()
        {
        }

        public function move():void
        {
            position.x = position.x * velocity;
        }
    }
}
