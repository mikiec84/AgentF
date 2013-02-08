/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 11:32
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model.components
{
    import de.mediadesign.gd1011.studiof.services.*;
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;

    import flash.geom.Point;

    import starling.display.Sprite;

    public class Renderable implements IRenderable
    {
        public var position:PositionComponent;
        public var display:DisplayComponent;

        public function Renderable(pos:PositionComponent)
        {
            position = pos;
            display = new DisplayComponent();
        }
        public function render():void
        {
            display.view.x = position.x;
            display.view.y = position.y;
            display.view.rotation = position.currentRotation;
        }
    }
}
