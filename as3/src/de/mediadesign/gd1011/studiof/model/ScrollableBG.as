/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 13.02.13
 * Time: 15:13
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;
    import de.mediadesign.gd1011.studiof.model.components.VelocityComponent;

    public class ScrollableBG implements IMovable
    {
        private var _position:PositionComponent;
        private var _velocity:VelocityComponent;

        public function ScrollableBG()
        {
            _position = new PositionComponent();
            _velocity = new VelocityComponent();
        }

        public function move(time:Number):void
        {
            _position.x -= 8;
        }

        public function get position():PositionComponent
        {
            return _position;
        }

        public function set position(value:PositionComponent):void
        {
            _position = value;
        }

        public function get velocity():VelocityComponent
        {
            return _velocity;
        }

        public function set velocity(value:VelocityComponent):void
        {
            _velocity = value;
        }
    }
}
