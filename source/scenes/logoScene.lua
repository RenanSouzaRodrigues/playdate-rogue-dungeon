LogoScene = {
    scene_manager = nil,
    logo = nil,
    current_time = nil,
    time_until_next_scene = nil,
}

function LogoScene:build(scene_manager)    
    -- Scene manager reference is needed in all the scenes because I need a way to control the current scene display -Dallai
    LogoScene.scene_manager = scene_manager
    assert(LogoScene.scene_manager, "Scene Manager is null or invalid at LogoScene")

    -- just a small counter to display the studio logo for some amount of time -Dallai
    LogoScene.current_time = playdate.getElapsedTime()
    LogoScene.time_until_next_scene = LogoScene.current_time + Globals.game_values.logo_duration

    LogoScene.logo, error = playdate.graphics.image.new(Globals.assets.images.studio_logo)
    assert(LogoScene.logo, error)

    playdate.graphics.clear(playdate.graphics.kColorBlack)
    LogoScene.logo:draw(0, 0)
end

function LogoScene:update()
    if LogoScene.current_time >= LogoScene.time_until_next_scene then
        playdate.graphics.clear(playdate.graphics.kColorBlack)
        LogoScene.scene_manager:open_scene(2) -- define the next scene    
    end
    LogoScene.current_time = playdate.getElapsedTime()
end

return LogoScene