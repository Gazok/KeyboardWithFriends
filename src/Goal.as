package {

    import flash.geom.Rectangle;
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;

    public class Goal extends Entity
    {
        public const thickness:int = 20;
        public function Goal(player:uint)
        {
            const dirX:int = GameWorld.playerDirs[player][0];
            const dirY:int = GameWorld.playerDirs[player][1];

            const xComp:int = Math.abs(dirX);
            const yComp:int = Math.abs(dirY);

            const sidePosX:Number = FP.halfWidth + dirX*(FP.halfWidth - thickness / 2);
            const sidePosY:Number = FP.halfHeight + dirY*(FP.halfHeight - thickness / 2);

            x = yComp * FP.halfWidth + sidePosX * xComp;
            y = xComp * FP.halfHeight + sidePosY * yComp;

            const cWidth:int = yComp * FP.screen.width + xComp * thickness;
            const cHeight:int = xComp * FP.screen.height + yComp * thickness;

            var c:Image = Image.createRect(cWidth, cHeight);
            c.color = GameWorld.playerColours[player];
            c.centerOrigin();

            addGraphic(c);
        }
    }
}
