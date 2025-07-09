import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "tools/globals"
import "scenes/logoScene"
import "scenes/combatScene"

SceneManager = {
    current_active_scene_index = 1,
    game_scenes = {
        LogoScene,
        CombatScene
    }
}

function SceneManager:build_scene()
    if not SceneManager.game_scenes[SceneManager.current_active_scene_index] then 
        print("Current scene intex is invalid. Current scene Index: ", SceneManager.current_active_scene_index)
        return
    end
    SceneManager.game_scenes[SceneManager.current_active_scene_index]:build(SceneManager)
end

function SceneManager:open_scene(scene_index) 
    if scene_index == 0 or scene_index == SceneManager.current_active_scene_index then return end
    if SceneManager.game_scenes[scene_index] then
        SceneManager.current_active_scene_index = scene_index
        SceneManager:build_scene()
    else
        print("SceneManager: provided scene index garbage. Provided scene: ", scene_index)
    end
end

function SceneManager:update()
    SceneManager.game_scenes[SceneManager.current_active_scene_index]:update()
end

return SceneManager