/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 08.02.13
 * Time: 11:59
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model.components
{
    import de.mediadesign.gd1011.studiof.manager.MovementManager;
    import de.mediadesign.gd1011.studiof.services.*;
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;

    public class Moveable implements IMoveable
    {
        [Inject]
        public var MM:MovementManager;
        [PostConstruct]
        public var position:PositionComponent;
        public var velocity:VelocityComponent;
        public var horizontalVelocityEnabled:Boolean;
        public var verticalVelocityEnabled:Boolean;


        public function Moveable()
        {
            position = new PositionComponent();
            velocity = new VelocityComponent();
        }

        public function move():void
        {
            MM.update(this);
        }
    }
}
