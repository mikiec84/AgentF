/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 06.03.13
 * Time: 11:17
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;
    import de.mediadesign.gd1011.studiof.services.JSONReader;

    public class FortFox implements IMovable
    {
        private var _running:Boolean = true;
        public var position:PositionComponent;
        private var fortVelocity:Number;

        public function FortFox()
        {
            position = new PositionComponent();
            position.x = GameConsts.STAGE_WIDTH;

            var JSONExtractedInformation:Object = JSONReader.read("config")["background"]["layer02"]
            fortVelocity = JSONExtractedInformation["speed"];
        }

        public function move(time:Number):void
        {
            if (_running)
            {
                position.x -= fortVelocity*time;
                position.y = -30;
            }
        }

        public function stop():void
        {
            _running = false;
        }

        public function resume():void
        {
        }
    }
}
