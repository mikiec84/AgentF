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

    public class ScrollBackgroundView extends Sprite
    {
        private const NUMBER_OF_TILESYSTEMPARTS:uint = 2;

        public function ScrollBackgroundView()
        {
            var bgImage:Image;
            alpha = 0;
            switch (Math.round(Math.random()* NUMBER_OF_TILESYSTEMPARTS))
            {
                case(0):
                    bgImage = Assets.getImage("Gras01_texture");
                    break;
                case(1):
                    bgImage = Assets.getImage("Gras02_texture");
                    break;
                default:
                    bgImage = Assets.getImage("Gras01_texture");
                    break;
            }
            addChild(bgImage);
        }
    }
}
