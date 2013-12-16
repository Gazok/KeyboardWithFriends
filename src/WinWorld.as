package {

    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Image;

    public class WinWorld extends World
    {
        private var winner_:uint;
        public function WinWorld(winner:uint)
        {
            winner_ = winner;

            var bg:Image = new Image(A.bg);
            bg.color = GameWorld.playerColours[winner];
            addGraphic(bg);
            const col:uint = GameWorld.playerColours[winner];

            switch (winner)
            {
                case 0:
                    add(new KeyEntity(125,  250, "O", col));
                    add(new KeyEntity(195,  250, "R", col));
                    add(new KeyEntity(265,  250, "A", col));
                    add(new KeyEntity(335,  250, "N", col));
                    add(new KeyEntity(405,  250, "G", col));
                    add(new KeyEntity(475,  250, "E", col));
                    break;
                case 1:
                    add(new KeyEntity(160,  250, "B", col));
                    add(new KeyEntity(230,  250, "L", col));
                    add(new KeyEntity(300,  250, "A", col));
                    add(new KeyEntity(370,  250, "C", col));
                    add(new KeyEntity(440,  250, "K", col));
                    break;
                case 2:
                    add(new KeyEntity(125,  250, "P", col));
                    add(new KeyEntity(195,  250, "U", col));
                    add(new KeyEntity(265,  250, "R", col));
                    add(new KeyEntity(335,  250, "P", col));
                    add(new KeyEntity(405,  250, "L", col));
                    add(new KeyEntity(475,  250, "E", col));
                    break;
                case 3:
                    add(new KeyEntity(160,  250, "W", col));
                    add(new KeyEntity(230,  250, "H", col));
                    add(new KeyEntity(300,  250, "I", col));
                    add(new KeyEntity(370,  250, "T", col));
                    add(new KeyEntity(440,  250, "E", col));

                default: break;
            }

            add(new KeyEntity(195,  350, "W", col));
            add(new KeyEntity(265,  350, "I", col));
            add(new KeyEntity(335,  350, "N", col));
            add(new KeyEntity(405,  350, "S", col));

            FP.alarm(2, startGame);
        }

        public function startGame():void
        {
            FP.world = new GameWorld(winner_);
        }
    }
}
