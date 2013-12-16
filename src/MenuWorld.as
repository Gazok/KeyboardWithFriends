package {

    import net.flashpunk.World;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;

    public class MenuWorld extends World
    {
        public function MenuWorld()
        {
            var bg:Image = new Image(A.bg);
            bg.color = GameWorld.playerColours[0];
            addGraphic(bg);
            add(new KeyEntity(230,  150, "K", rCol()));
            add(new KeyEntity(300,  150, "E", rCol()));
            add(new KeyEntity(370,  150, "Y", rCol()));

            add(new KeyEntity(160,  250, "B", rCol()));
            add(new KeyEntity(230,  250, "O", rCol()));
            add(new KeyEntity(300,  250, "A", rCol()));
            add(new KeyEntity(370,  250, "R", rCol()));
            add(new KeyEntity(440,  250, "D", rCol()));

            add(new KeyEntity(195,  350, "W", rCol()));
            add(new KeyEntity(265,  350, "I", rCol()));
            add(new KeyEntity(335,  350, "T", rCol()));
            add(new KeyEntity(405,  350, "H", rCol()));

            add(new KeyEntity(90,  450, "F", rCol()));
            add(new KeyEntity(160,  450, "R", rCol()));
            add(new KeyEntity(230,  450, "I", rCol()));
            add(new KeyEntity(300,  450, "E", rCol()));
            add(new KeyEntity(370,  450, "N", rCol()));
            add(new KeyEntity(440,  450, "D", rCol()));
            add(new KeyEntity(510,  450, "S", rCol()));

            FP.alarm(4, startGame);
        }

        public function startGame():void
        {
            FP.world = new GameWorld;
        }

        private function rCol():uint
        {
            return GameWorld.playerColours[Math.round(FP.random * 3)];
            
        }
    }
}
