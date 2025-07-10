-- ==========================================================
-- Player Properties
-- ==========================================================
local player = {
    position = {x = 80, y = Globals.game_values.half_Y + 32}, life = 100, max_life = 100, mana = 20, max_mana = 20, sprite = nil, state = "idle",
    attacks = 2, max_attacks = 2
}

function player:init()
    -- load the player image and sprite and adds it to the game render table -Renan
    local player_image_reference, error = playdate.graphics.image.new(Globals.assets.sprites.player)
    assert(player_image_reference, error)

    player.sprite, error = playdate.graphics.sprite.new(player_image_reference)
    assert(player.sprite, error)
    
    player.sprite:setCenter(Globals.game_values.sprite_botton_middle.x, Globals.game_values.sprite_botton_middle.y)
    player.sprite:moveTo(player.position.x, player.position.y)
    player.sprite:add()
end

function player:update()
    local player_y_scale = Globals:calculate_idle("player")
    player.sprite:setScale(1, player_y_scale)
end



-- ==========================================================
-- Current Enemy Properties
-- ==========================================================
local current_enemy = {
    position = {x = 320, y = Globals.game_values.half_Y + 32}, life = 0, max_life = 0, mana = 0, max_mana = 0, sprite = nil, state = "idle",
    attacks = 0, max_attacks = 0
}

function current_enemy:init()
    local enemy_image_reference, error = playdate.graphics.image.new(Globals.assets.sprites.enemy_bird)
    assert(enemy_image_reference, error)

    current_enemy.sprite, error = playdate.graphics.sprite.new(enemy_image_reference)
    assert(current_enemy.sprite, error)

    current_enemy.sprite:setCenter(Globals.game_values.sprite_botton_middle.x, Globals.game_values.sprite_botton_middle.y)
    current_enemy.sprite:moveTo(current_enemy.position.x, current_enemy.position.y)
    current_enemy.sprite:add()
end

function current_enemy:update()
    local enemy_y_scale = Globals:calculate_idle("enemy")
    current_enemy.sprite:setScale(1, enemy_y_scale)
end



-- ==========================================================
-- UI Elements Properties
-- ==========================================================
local ui_elements = {
    attack_button = {black = nil, white = nil, sprite = nil, is_active = true, position = {x = Globals.game_values.half_X, y = Globals.game_values.half_Y}},
    magic_button = {black = nil, white = nil, sprite = nil, is_active = false, position = {x = Globals.game_values.half_X, y = Globals.game_values.half_Y - 40}},
    items_button = {black = nil, white = nil, sprite = nil, is_active = false, position = {x = Globals.game_values.half_X, y = Globals.game_values.half_Y + 40}}
}

function ui_elements:init()
    ui_elements.attack_button.black, error = playdate.graphics.image.new(Globals.assets.sprites.attack_button_black)
    assert(ui_elements.attack_button.black, error)
    ui_elements.attack_button.white, error = playdate.graphics.image.new(Globals.assets.sprites.attack_button_white)
    assert(ui_elements.attack_button.white, error);
    ui_elements.attack_button.sprite, error = playdate.graphics.sprite.new(ui_elements.attack_button.white)
    assert(ui_elements.attack_button.sprite, error)
    ui_elements.attack_button.sprite:moveTo(ui_elements.attack_button.position.x, ui_elements.attack_button.position.y)
    ui_elements.attack_button.sprite:setScale(Globals.game_values.button_active_scale)
    ui_elements.attack_button.sprite:add()

    ui_elements.magic_button.black, error = playdate.graphics.image.new(Globals.assets.sprites.magic_button_black)
    assert(ui_elements.magic_button.black, error)
    ui_elements.magic_button.white, error = playdate.graphics.image.new(Globals.assets.sprites.magic_button_white)
    assert(ui_elements.magic_button.white, error);
    ui_elements.magic_button.sprite, error = playdate.graphics.sprite.new(ui_elements.magic_button.black)
    assert(ui_elements.magic_button.sprite, error)
    ui_elements.magic_button.sprite:moveTo(ui_elements.magic_button.position.x, ui_elements.magic_button.position.y)
    ui_elements.magic_button.sprite:setScale(Globals.game_values.button_default_scale)
    ui_elements.magic_button.sprite:add()

    ui_elements.items_button.black, error = playdate.graphics.image.new(Globals.assets.sprites.items_button_black)
    assert(ui_elements.items_button.black, error)
    ui_elements.items_button.white, error = playdate.graphics.image.new(Globals.assets.sprites.items_button_white)
    assert(ui_elements.items_button.white, error);
    ui_elements.items_button.sprite, error = playdate.graphics.sprite.new(ui_elements.items_button.black)
    assert(ui_elements.items_button.sprite, error)
    ui_elements.items_button.sprite:moveTo(ui_elements.items_button.position.x, ui_elements.items_button.position.y)
    ui_elements.items_button.sprite:setScale(Globals.game_values.button_default_scale)
    ui_elements.items_button.sprite:add()
end

function ui_elements:select_button(button)
    if not button then print("button is invalid", button) return end

    button.is_active = true
    button.sprite:setImage(button.white, 0, Globals.game_values.button_active_scale)
end

function ui_elements:deselect_button(button)
    if not button then print("button is invalid", button) return end

    button.is_active = false
    button.sprite:setImage(button.black, 0, Globals.game_values.button_default_scale)
end

function ui_elements:handle_buttons()
    -- when the player releases the up button -Renan
    if playdate.buttonJustReleased(playdate.kButtonUp) then
        print("up button released")
        if ui_elements.magic_button.is_active then return end

        if ui_elements.attack_button.is_active then
            ui_elements:deselect_button(ui_elements.attack_button)
            ui_elements:select_button(ui_elements.magic_button)
            -- TODO: play the ui sound
        end

        if ui_elements.items_button.is_active then
            ui_elements:deselect_button(ui_elements.items_button)
            ui_elements:select_button(ui_elements.attack_button)
            -- TODO: play the ui sound
        end
    end

    if playdate.buttonJustReleased(playdate.kButtonDown) then
        print("down button released")
        if ui_elements.items_button.is_active then return end

        if ui_elements.attack_button.is_active then
            ui_elements:deselect_button(ui_elements.attack_button)
            ui_elements:select_button(ui_elements.items_button)
            -- TODO: play the ui sound
        end

        if ui_elements.magic_button.is_active then
            ui_elements:deselect_button(ui_elements.magic_button)
            ui_elements:select_button(ui_elements.attack_button)
            -- TODO: play the ui sound
        end
    end
end

function ui_elements:update()
    ui_elements:handle_buttons()
end


-- ==========================================================
-- Current Enemy Properties
-- ==========================================================
CombatScene = {combat_song = nil, background = nil, state = "begin"}

function CombatScene:build()
    -- Play the scene background music. There is no logic yet to handle music settings or any thing like
    -- that yet, but for the moment, I don't really care that much. -Renan
    CombatScene.combat_song, error = playdate.sound.fileplayer.new(Globals.assets.musics.combat_song)
    assert(CombatScene.combat_song, error)
    if not CombatScene.combat_song:isPlaying() then CombatScene.combat_song:play(0) end
    
    CombatScene.background, error = playdate.graphics.image.new(Globals.assets.images.arena)
    assert(CombatScene.background, error)

    ui_elements:init()
    player:init()
    current_enemy:init()
end

function CombatScene:update_entities()
    ui_elements:update()
    player:update()
    current_enemy:update()
    playdate.graphics.sprite.update()
end

function CombatScene:update()
    playdate.graphics.clear(playdate.graphics.kColorClear)
    playdate.graphics.setBackgroundColor(playdate.graphics.kColorClear)
    CombatScene.background:draw(0, 0)

    CombatScene:update_entities()

    -- TODO Handle the game state
end

return CombatScene