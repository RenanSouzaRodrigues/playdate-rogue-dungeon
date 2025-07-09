LogoScene = {logo = nil, logo_alpha = 0, current_time = 0, time_to_await = 0, sound = nil, sound_played = false, state = "fadeIn" }

function LogoScene:build()
    -- just a small counter to display the studio logo for some amount of time -Dallai
    LogoScene.logo, error = playdate.graphics.image.new(Globals.assets.images.studio_logo)
    assert(LogoScene.logo, error)

    LogoScene.sound, error = playdate.sound.sampleplayer.new(Globals.assets.sounds.logo_sound)
    assert(LogoScene.sound, error)

    LogoScene.current_time = playdate.getElapsedTime()
    LogoScene.time_to_await = LogoScene.current_time + Globals.game_values.logo_duration
end

function LogoScene:update()
    playdate.graphics.clear(playdate.graphics.kColorBlack)

    if not LogoScene.sound_played then
        LogoScene.sound:play() 
        LogoScene.sound_played = true
    end

    if LogoScene.state == "fadeIn" then
        LogoScene.logo:drawFaded(0, 0, LogoScene.logo_alpha, playdate.graphics.image.kDitherTypeAtkinson)
        LogoScene.logo_alpha += 0.05
        if LogoScene.logo_alpha >= 1 then LogoScene.state = "wait" end
        return
    end

    if LogoScene.state == "wait" then
        LogoScene.logo:draw(0,0)
        if LogoScene.current_time >= LogoScene.time_to_await then LogoScene.state = "fadeOut" end
        LogoScene.current_time = playdate.getElapsedTime()
        return
    end
    
    if LogoScene.state == "fadeOut" then
        LogoScene.logo:drawFaded(0, 0, LogoScene.logo_alpha, playdate.graphics.image.kDitherTypeAtkinson)
        LogoScene.logo_alpha -= 0.05
        if LogoScene.logo_alpha <= 0 then SceneManager:open_scene(2) end
    end
end

return LogoScene