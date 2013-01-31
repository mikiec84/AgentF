/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 31.01.13
 * Time: 11:46
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof
{
    import mediators.StarlingContextViewMediator;
    import mediators.StarlingStageMediator;
    import mediators.StarlingSubViewMediator;

    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;

    import starling.display.Stage;

    import views.StarlingSubView;

    public class StarlingConfig
    {
        [Inject]
        public var mediatorMap:IMediatorMap;

        public function configure() : void
        {
            mediatorMap.map( Game ).toMediator(StarlingContextViewMediator);
            mediatorMap.map( Stage ).toMediator(StarlingStageMediator);
            mediatorMap.map( StarlingSubView ).toMediator(StarlingSubViewMediator);
        }
    }
}
