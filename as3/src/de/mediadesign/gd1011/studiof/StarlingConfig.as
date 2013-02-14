/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 31.01.13
 * Time: 11:46
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof
{
    import de.mediadesign.gd1011.studiof.command.ImplementBackgroundCommand;
    import de.mediadesign.gd1011.studiof.command.InitGameCommand;
    import de.mediadesign.gd1011.studiof.command.RegisterUnitCommand;
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.Level;
    import de.mediadesign.gd1011.studiof.model.Renderable;
    import de.mediadesign.gd1011.studiof.model.Score;
    import de.mediadesign.gd1011.studiof.model.ScrollableBG;
    import de.mediadesign.gd1011.studiof.model.User;
    import de.mediadesign.gd1011.studiof.services.GameLoop;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;
    import de.mediadesign.gd1011.studiof.view.BackgroundView;
    import de.mediadesign.gd1011.studiof.view.GUI;
    import de.mediadesign.gd1011.studiof.view.GameView;
    import de.mediadesign.gd1011.studiof.view.MainView;
	import de.mediadesign.gd1011.studiof.view.StartScreenView;
	import de.mediadesign.gd1011.studiof.view.mediators.BackgroundViewMediator;
    import de.mediadesign.gd1011.studiof.view.mediators.GUIMediator;
    import de.mediadesign.gd1011.studiof.view.mediators.GameViewMediator;
    import de.mediadesign.gd1011.studiof.view.mediators.MainViewMediator;
	import de.mediadesign.gd1011.studiof.view.mediators.StartScreenViewMediator;

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
            modelMap.map(Renderable);
            modelMap.map(Level).asSingleton();
            modelMap.map(Score).asSingleton();
            modelMap.map(User).asSingleton();
            modelMap.map(MoveProcess).asSingleton();
            modelMap.map(RenderProcess).asSingleton();
            modelMap.map(GameLoop).asSingleton();
        }

        private function initCommands():void
        {
            commandMap.map(GameConsts.INIT_GAME).toCommand(InitGameCommand);
            commandMap.map(GameConsts.IMPL_BG).toCommand(ImplementBackgroundCommand);
            commandMap.map(GameConsts.REGISTER_UNIT).toCommand(RegisterUnitCommand);
        }

        public function initMediators() : void
        {
            mediatorMap.map(MainView).toMediator(MainViewMediator);
			mediatorMap.map(StartScreenView).toMediator(StartScreenViewMediator);
			mediatorMap.map(GameView).toMediator(GameViewMediator);
			mediatorMap.map(GUI).toMediator(GUIMediator);
            mediatorMap.map(BackgroundView).toMediator(BackgroundViewMediator);
        }


    }
}
