package {
    import net.flashpunk.Engine;
    import net.flashpunk.FP;

    public class Main extends Engine
    {
        public function Main()
        {
            super(600, 600);
        }

        override public function init():void
        {
            FP.console.enable();
            FP.world = new GameWorld;
        }
    }
}
