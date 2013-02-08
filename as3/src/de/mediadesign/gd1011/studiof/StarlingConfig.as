/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 31.01.13
 * Time: 11:46
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof
{
	import de.mediadesign.gd1011.studiof.commands.InitPlayerCommand;
	import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.manager.Game;
    import de.mediadesign.gd1011.studiof.manager.LevelManager;
    import de.mediadesign.gd1011.studiof.manager.MovementManager;
    import de.mediadesign.gd1011.studiof.manager.UnitManager;
	import de.mediadesign.gd1011.studiof.model.Level;
	import de.mediadesign.gd1011.studiof.model.Score;
	import de.mediadesign.gd1011.studiof.model.User;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.Render;
	import de.mediadesign.gd1011.studiof.view.BackgroundView;
	import de.mediadesign.gd1011.studiof.view.GUI;
	import de.mediadesign.gd1011.studiof.view.GameView;
	import de.mediadesign.gd1011.studiof.view.MainView;
	import de.mediadesign.gd1011.studiof.view.mediators.BackgroundViewMediator;
	import de.mediadesign.gd1011.studiof.view.mediators.GUIMediator;
	import de.mediadesign.gd1011.studiof.view.mediators.GameViewMediator;
	import de.mediadesign.gd1011.studiof.view.mediators.MainViewMediator;

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
//            var playerEvent:GameEvent = new GameEvent(GameConsts.INIT_PLAYER, GameConsts.INIT_PLAYER, JSONReader.read("player") );
//            dispatcher.dispatchEvent(playerEvent);  //WTF ?? cast to Event
        }

        private function initModels():void
        {
            modelMap.map(Level).asSingleton();
            modelMap.map(Score).asSingleton();
            modelMap.map(User).asSingleton();
            modelMap.map(UnitManager).asSingleton();
            modelMap.map(Render).asSingleton();
            modelMap.map(Game).asSingleton();
            modelMap.map(MovementManager).asSingleton();
            modelMap.map(LevelManager).asSingleton();
            modelMap.map(UnitManager).asSingleton();
            modelMap.map(MoveProcess).asSingleton();
            modelMap.map(Render).asSingleton();
        }

        private function initCommands():void
        {
            commandMap.map(GameConsts.INIT_PLAYER).toCommand(InitPlayerCommand);
        }

        public function initMediators() : void
        {
            mediatorMap.map(MainView).toMediator(MainViewMediator);
			mediatorMap.map(GameView).toMediator(GameViewMediator);
			mediatorMap.map(GUI).toMediator(GUIMediator);
            mediatorMap.map(BackgroundView).toMediator(BackgroundViewMediator);
        }


    }
}
