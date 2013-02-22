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
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	public class BGTile implements IMovable
    {
        private var _position:PositionComponent;
        private var _velocity:VelocityComponent;
		private var _layerID:String;
		public var moving:Boolean = true;

        public function BGTile(layerID:String)
        {
			_layerID = layerID;
            _position = new PositionComponent();
            _velocity = new VelocityComponent();

        }

		public function get layerID():String
		{
			return _layerID;
		}

        public function move(time:Number):void
        {
			if(moving)
           		_position.x -= velocity.velocityX*time;
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

        public function stop():void {
        }

        public function resume():void {
        }
    }
}
