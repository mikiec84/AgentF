/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 31.01.13
 * Time: 11:46
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof
{
    import de.mediadesign.gd1011.studiof.mediators.StarlingContextViewMediator;

    import flash.events.IEventDispatcher;

    import org.swiftsuspenders.Injector;

    import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;

    public class StarlingConfig
    {
        [Inject]
        public var modelMap:Injector;
        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var commandMap:IEventCommandMap;
        [Inject]
        public var dispatcher:IEventDispatcher;

        [PostConstruct]
        public function configure():void
        {
            initModels();
            initCommands();
            initMediators();
        }

        private function initModels():void
        {
        }

        private function initCommands():void
        {
        }

        public function initMediators() : void
        {
            mediatorMap.map( Game ).toMediator(StarlingContextViewMediator);
        }


    }
}
