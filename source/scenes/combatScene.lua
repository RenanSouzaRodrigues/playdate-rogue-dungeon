-- ==========================================================
-- Player Properties
-- ==========================================================
Player = {
    position = {x = 80, y = Globals.game_values.half_Y + 32}, life = 100, max_life = 100, mana = 20, max_mana = 20, sprite = nil, state = "idle",
    attacks = 2, max_attacks = 2
}

function Player:init()
    -- load the player image and sprite and adds it to the game render table -Renan
    local player_image_reference, error = playdate.graphics.image.new(Globals.assets.sprites.player)
    assert(player_image_reference, error)

    Player.sprite, error = playdate.graphics.sprite.new(player_image_reference)
    assert(Player.sprite, error)
    
    Player.sprite:setCenter(Globals.game_values.sprite_botton_middle.x, Globals.game_values.sprite_botton_middle.y)
    Player.sprite:moveTo(Player.position.x, Player.position.y)
    Player.sprite:add()
end

function Player:update()
    local player_y_scale = Globals:calculate_idle("player")
    Player.sprite:setScale(1, player_y_scale)
end



-- ==========================================================
-- Current Enemy Properties
-- ==========================================================
CurrentEnemy = {
    position = {x = 320, y = Globals.game_values.half_Y + 32}, life = 0, max_life = 0, mana = 0, max_mana = 0, sprite = nil, state = "idle",
    attacks = 0, max_attacks = 0
}

function CurrentEnemy:init()
    local enemy_image_reference, error = playdate.graphics.image.new(Globals.assets.sprites.enemy_bird)
    assert(enemy_image_reference, error)

    CurrentEnemy.sprite, error = playdate.graphics.sprite.new(enemy_image_reference)
    assert(CurrentEnemy.sprite, error)
end

function CurrentEnemy:update()
end



-- ==========================================================
-- UI Elements Properties
-- ==========================================================
UIElements = {}



-- ==========================================================
-- Current Enemy Properties
-- ==========================================================
CombatScene = {scene_manager = nil, combat_song = nil, background = nil}

function CombatScene:build(scene_manager)
    CombatScene.scene_manager = scene_manager
    assert(LogoScene.scene_manager, "Scene Manager is null or invalid at CombatScene")

    -- Play the scene background music. There is no logic yet to handle music settings or any thing like
    -- that yet, but for the moment, I don't really care that much. -Renan
    CombatScene.combat_song, error = playdate.sound.fileplayer.new(Globals.assets.musics.combat_song)
    assert(CombatScene.combat_song, error)
    if not CombatScene.combat_song:isPlaying() then CombatScene.combat_song:play(0) end
    
    CombatScene.background, error = playdate.graphics.image.new(Globals.assets.images.arena)
    assert(CombatScene.background, error)

    playdate.graphics.setBackgroundColor(playdate.graphics.kColorClear)

    CombatScene.player.image, error = playdate.graphics.image.new(Globals.assets.sprites.player)
    assert(CombatScene.player.image, error)
    CombatScene.player.sprite, error = playdate.graphics.sprite.new(CombatScene.player.image)
    assert(CombatScene.player.sprite, error)
    CombatScene.player.sprite:setCenter(0.5, 1)
    CombatScene.player.sprite:moveTo(CombatScene.player.position.x, CombatScene.player.position.y)
    CombatScene.player.sprite:add()

    CombatScene.current_enemy.image, error = playdate.graphics.image.new(Globals.assets.sprites.enemy_bird)
    assert(CombatScene.current_enemy.image, error)
    CombatScene.current_enemy.sprite, error = playdate.graphics.sprite.new(CombatScene.current_enemy.image)
    assert(CombatScene.current_enemy.sprite, error)
    CombatScene.current_enemy.sprite:setCenter(0.5, 1)
    CombatScene.current_enemy.sprite:moveTo(CombatScene.current_enemy.position.x, CombatScene.current_enemy.position.y)
    CombatScene.current_enemy.sprite:add()
end

function CombatScene:update()
    local enemy_y_scale =  Globals:calculate_idle("enemy")

    playdate.graphics.clear(playdate.graphics.kColorBlack)
    CombatScene.background:draw(0, 0)

    Player:update()
    CurrentEnemy:update()

    playdate.graphics.sprite.update()
end

return CombatScene