-- Importing libraries used for drawCircleAtPoint and crankIndicator
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "tools/globals"
import "sceneManager"

SceneManager:build_scene()

-- runs at 30 fps max on the playdate console. max resolution is 400x240
function playdate.update()
    SceneManager:update()

    if Globals.debug then
        playdate.drawFPS(2, 2)
    end

end

