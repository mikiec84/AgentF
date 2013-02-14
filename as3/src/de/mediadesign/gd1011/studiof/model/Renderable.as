/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 11:32
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;

    import starling.display.Sprite;

    public class Renderable
    {
        private var position:PositionComponent;
        public var view:Sprite;

        public function Renderable(pos:PositionComponent, view:Sprite)
        {
            this.position = pos;
            this.view = view;
        }

        public function render(time:Number):void
        {   view.alpha = 1;
            view.x = position.x;
            view.y = position.y;
        }
    }
}
