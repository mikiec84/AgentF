/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 09:48
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import flash.geom.Point;

    import starling.display.DisplayObject;

    public class BackgroundView implements IRenderable
    {
        public var view:DisplayObject;
        public var position:Point;
        public var rotation:Number;

        public function render():void
        {
            view.x = position.x;
            view.y = position.y;
            view.rotation = rotation;
        }
    }
}
