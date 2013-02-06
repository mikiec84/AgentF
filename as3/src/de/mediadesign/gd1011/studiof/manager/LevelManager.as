/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:46
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.manager
{
    import de.mediadesign.gd1011.studiof.model.Level;

    public class LevelManager
    {
        [Inject]
        public var levelModel:Level;

        [PostConstruct]
        public function LevelManager()
        {

        }
    }
}
