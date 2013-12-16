package {

    import flash.geom.Rectangle;
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.graphics.Image;

    public class Goal extends Entity
    {
        public const thickness:int = 20;
        private var player_:uint;
        private var world_:GameWorld;
        private var scoreText_:Text = new Text("0",0,0, { size: 52,
                                                          font: "keyFont" });

        public function Goal(player:uint, world:GameWorld)
        {
            player_ = player;
            world_ = world;

            // Player-specific values
            const dirX:int = GameWorld.playerDirs[player][0];
            const dirY:int = GameWorld.playerDirs[player][1];

            const xComp:int = Math.abs(dirX);
            const yComp:int = Math.abs(dirY);

            // Set up score text

            // Set up entity
            const posX:Number = FP.halfWidth +
                                dirX*(FP.halfWidth - thickness / 2);
            const posY:Number = FP.halfHeight +
                                dirY*(FP.halfHeight - thickness / 2);

            x = yComp * FP.halfWidth + posX * xComp;
            y = xComp * FP.halfHeight + posY * yComp;
            type = "goal";// + player.toString();

            width = yComp * FP.screen.width + xComp * thickness;
            height = xComp * FP.screen.height + yComp * thickness;
            centerOrigin();

            // Set up image
            var goalImage:Image = new Image(A.goal);
            goalImage.centerOrigin();
            goalImage.color = GameWorld.playerColours[player];
            goalImage.angle = -90 * player;

            const imageSize:int = goalImage.height;

            const imagePosX:Number = FP.halfWidth +
                                     dirX*(FP.halfWidth - imageSize / 2);
            const imagePosY:Number = FP.halfHeight +
                                     dirY*(FP.halfHeight - imageSize / 2);

            goalImage.x = yComp * FP.halfWidth + imagePosX * xComp;
            goalImage.y = xComp * FP.halfHeight + imagePosY * yComp;

            addGraphic(goalImage);

            // Correct image for entity
            goalImage.x -= x;
            goalImage.y -= y;
        }

        public override function update():void
        {
            var e:Entity = collide("key",x,y);
            if (e)
            {
                e.x = FP.halfWidth;
                e.y = FP.halfHeight;
            }
        }
    }
}
