/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 31.01.13
 * Time: 11:46
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof
{
    import de.mediadesign.gd1011.studiof.commands.InitPlayer;
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.manager.UnitManager;
    import de.mediadesign.gd1011.studiof.services.Game;
    import de.mediadesign.gd1011.studiof.services.JsonReader;

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

            // Weitere Parameter müssen übergeben werden
            var playerEvent:GameEvent = new GameEvent(GameConsts.INIT_PLAYER, GameConsts.INIT_PLAYER, JsonReader.readJSON("player") );
            dispatcher.dispatchEvent(playerEvent);  //WTF ?? cast to Event
        }

        private function initModels():void
        {
            modelMap.map(UnitManager).asSingleton();
        }

        private function initCommands():void
        {
            commandMap.map(GameConsts.INIT_PLAYER).toCommand(InitPlayer);
        }

        public function initMediators() : void
        {
            mediatorMap.map( Game ).toMediator(StarlingContextViewMediator);
        }


    }
}
