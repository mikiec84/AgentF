/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:59
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import de.mediadesign.gd1011.studiof.model.Level;

    import starling.display.Sprite;

    public class GameScene extends Sprite
    {
        private var currentLevel:Level;

        public function GameScene(level:Level = null)
        {
            currentLevel = level;
        }
    }
}
