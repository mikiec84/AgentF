/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 13.02.13
 * Time: 09:21
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import starling.display.Quad;

    import starling.display.Sprite;

    public class BulletView extends Sprite
    {
        public function BulletView()
        {
            var q:Quad = new Quad(50,10,0xFFFFFF);
            q.y += 25;
            alpha = 0;
            addChildAt(q, 0);
        }
    }
}
