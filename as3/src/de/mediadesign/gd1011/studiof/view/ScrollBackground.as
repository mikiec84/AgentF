/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 13.02.13
 * Time: 13:30
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import de.mediadesign.gd1011.studiof.services.Assets;

    import starling.display.Image;
    import starling.display.Sprite;

    public class ScrollBackground extends Sprite
    {
        public function ScrollBackground()
        {
            var bgImage1:Image = Assets.getImage("Gras01_texture");
            //bgImage1.y = 200;
            addChild(bgImage1);

            var bgImage2:Image = Assets.getImage("Gras02_texture");
            bgImage2.x += 855;
            addChild(bgImage2);
        }
    }
}
