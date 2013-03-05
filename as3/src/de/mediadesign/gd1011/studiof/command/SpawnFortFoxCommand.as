package de.mediadesign.gd1011.studiof.command
{
    import de.mediadesign.gd1011.studiof.services.LevelProcess;

    import robotlegs.bender.bundles.mvcs.Command;

    public class SpawnFortFoxCommand extends Command
    {

        [Inject]
        public var level:LevelProcess;

        override public function execute():void
        {
            level.spawnBoss();
        }
    }
}
