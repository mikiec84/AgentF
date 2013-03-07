/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 07.02.13
 * Time: 14:09
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
	import de.mediadesign.gd1011.studiof.consts.GameConsts;
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
	import de.mediadesign.gd1011.studiof.services.LevelProcess;
	import de.mediadesign.gd1011.studiof.services.Sounds;
	import de.mediadesign.gd1011.studiof.view.GUI;
	import de.mediadesign.gd1011.studiof.view.GameOverScreenView;
	import de.mediadesign.gd1011.studiof.view.LifePointsView;
	import de.mediadesign.gd1011.studiof.view.PauseMenuView;

	import flash.events.IEventDispatcher;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.display.Button;
	import starling.events.Event;

	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class GUIMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:GUI;

		[Inject]
		public var level:LevelProcess;

		[Inject]
		public var sounds:Sounds;

		[Inject]
		public var assets:AssetManager;

		[Inject]
		public var dispatcher:IEventDispatcher;

		override public function initialize():void
		{
			addContextListener(ViewConsts.UPDATE_LIFEPOINTS,updateLifepoints);
			addContextListener(ViewConsts.SHOW_GAMEOVER,showGameOver);
            addContextListener(ViewConsts.ENEMY_KILLED, updateEnemyKilled);

			contextView.pauseButton = new Button(assets.getTexture("Lv"+(level.currentLevel+1)+"_PauseButton"));
			contextView.pauseButton.x = -contextView.pauseButton.width;
			contextView.addAdjusted(contextView.pauseButton,VAlign.TOP,HAlign.RIGHT);
			contextView.pauseButton.addEventListener(Event.TRIGGERED,onPause);

			contextView.lifepoints = new LifePointsView(assets, level.currentLevel);
			contextView.scaleGame(contextView.lifepoints);
			contextView.addChildAt(contextView.lifepoints,0);

		}

		private function onPause(e:Event):void
		{
			dispatcher.dispatchEvent(new GameEvent(GameConsts.PAUSE));
			if(contextView.pauseMenu == null)
			{
				contextView.pauseMenu = new PauseMenuView(assets,level.currentLevel);
				contextView.pauseMenu.x = -contextView.pauseMenu.width/2;
				contextView.pauseMenu.y = -contextView.pauseMenu.height/2;
				contextView.addAdjusted(contextView.pauseMenu,VAlign.CENTER,HAlign.CENTER);
				contextView.pauseMenu.continueButton.addEventListener(Event.TRIGGERED,onContinue);
				contextView.pauseMenu.restartButton.addEventListener(Event.TRIGGERED,onRestart);
			}
			else
				contextView.pauseMenu.visible = true;
			contextView.pauseButton.visible = false;


		}

		private function onContinue(e:Event):void
		{
			contextView.pauseButton.visible = true;
			contextView.pauseMenu.visible = false;
			dispatcher.dispatchEvent(new GameEvent(GameConsts.CONTINUE));
		}

        private function updateEnemyKilled(e:GameEvent):void
        {
            contextView.setEnemiesKilled(e.dataObj as int);
        }

		private function showGameOver(e:GameEvent):void
		{
			contextView.gameOverScreen = new GameOverScreenView(assets,level.currentLevel);
			contextView.addAdjusted(contextView.gameOverScreen, VAlign.CENTER,HAlign.CENTER);
			contextView.pauseButton.visible = false;
			contextView.gameOverScreen.restartButton.addEventListener(Event.TRIGGERED,onRestart);
			sounds.setBGSound(level.currentLevel,"outro",true, false);
		}

		private function onRestart(e:Event):void
		{
			level.clear();
			dispatcher.dispatchEvent(new GameEvent(GameConsts.RESTART));
		}

		private function updateLifepoints(e:GameEvent):void
		{
			contextView.setLifepoints(e.dataObj as int);
		}

		override public function destroy():void
		{

		}
	}
}
