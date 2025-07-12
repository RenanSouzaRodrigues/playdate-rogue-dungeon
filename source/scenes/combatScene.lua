local fight_alert_animation = {alpha=0, scale=2, timer=0}

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
    player.sprite:update()
end



-- ==========================================================
-- Current Enemy Properties
-- ==========================================================
local temporary_enemy = {}

local current_enemy = {
    position = {x = 320, y = Globals.game_values.half_Y + 32},
    level = 0,
    hp = 0,
    min_damage = 0,
    max_damage = 0, 
    defense = 0, 
    sprite = nil, 
    state = "idle",
}

function current_enemy:init()
    current_enemy.level = temporary_enemy.level
    current_enemy.hp = temporary_enemy.hp
    current_enemy.min_damage = temporary_enemy.min_damage
    current_enemy.max_damage = temporary_enemy.max_damage
    current_enemy.defense = temporary_enemy.defense

    local enemy_image_reference, error = playdate.graphics.image.new(temporary_enemy.image)
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
    current_enemy.sprite:update()
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
    button.is_active = true
    button.sprite:setImage(button.white, 0, Globals.game_values.button_active_scale)
end

function ui_elements:deselect_button(button)
    button.is_active = false
    button.sprite:setImage(button.black, 0, Globals.game_values.button_default_scale)
end

function ui_elements:handle_buttons()
    -- when the player releases the up button -Renan
    if playdate.buttonJustReleased(playdate.kButtonUp) then
        print("up button released")
        if ui_elements.magic_button.is_active then
            ui_elements:deselect_button(ui_elements.magic_button)
            ui_elements:select_button(ui_elements.items_button)
            return
        end

        if ui_elements.attack_button.is_active then
            ui_elements:deselect_button(ui_elements.attack_button)
            ui_elements:select_button(ui_elements.magic_button)
            return
            -- TODO: play the ui sound
        end

        if ui_elements.items_button.is_active then
            ui_elements:deselect_button(ui_elements.items_button)
            ui_elements:select_button(ui_elements.attack_button)
            return
            -- TODO: play the ui sound
        end
    end

    if playdate.buttonJustReleased(playdate.kButtonDown) then
        print("down button released")
        if ui_elements.items_button.is_active then
            ui_elements:deselect_button(ui_elements.items_button)
            ui_elements:select_button(ui_elements.magic_button)
            return
        end

        if ui_elements.attack_button.is_active then
            ui_elements:deselect_button(ui_elements.attack_button)
            ui_elements:select_button(ui_elements.items_button)
            return
            -- TODO: play the ui sound
        end

        if ui_elements.magic_button.is_active then
            ui_elements:deselect_button(ui_elements.magic_button)
            ui_elements:select_button(ui_elements.attack_button)
            return
            -- TODO: play the ui sound
        end
    end
end

function ui_elements:update()
    ui_elements:handle_buttons()
    ui_elements.attack_button.sprite:update()
    ui_elements.magic_button.sprite:update()
    ui_elements.items_button.sprite:update()
end


-- ==========================================================
-- Current Enemy Properties
-- ==========================================================
CombatScene = {combat_song = nil, state = "generate_encouter", dungeon_level = 1, fight_logo = nil, alpha = 0, scale = 1}

function CombatScene:build()
    -- Play the scene background music. There is no logic yet to handle music settings or any thing like
    -- that yet, but for the moment, I don't really care that much. -Renan
    CombatScene.combat_song, error = playdate.sound.fileplayer.new(Globals.assets.musics.combat_song)
    assert(CombatScene.combat_song, error)
    if not CombatScene.combat_song:isPlaying() then CombatScene.combat_song:play(0) end

    CombatScene.fight_logo, error = playdate.graphics.image.new(Globals.assets.sprites.fight_logo)
    assert(CombatScene.fight_logo, error)

    player:init()
    ui_elements:init()
end

function CombatScene:generate_encounter()
    temporary_enemy = Enemies:get_random_enemy_by_dungeon_floor(CombatScene.dungeon_level)
    printTable(temporary_enemy)
    assert(temporary_enemy, "generated enemy is nil or invalid")
    current_enemy.init(temporary_enemy)
    CombatScene.state = "pre-combat"
    print("state is now pre-combat")
end

function CombatScene:animate_fight_logo()
    if CombatScene.scale >= 2 then 
        CombatScene.state = "combat"
        return
    end

    CombatScene.fight_logo
        :fadedImage(CombatScene.alpha, playdate.graphics.image.kDitherTypeAtkinson)
        :scaledImage(CombatScene.scale)
        :drawCentered(Globals.game_values.half_X, Globals.game_values.half_Y)

    if CombatScene.scale < 2 then CombatScene.scale += 0.02 end

    CombatScene.alpha += 0.05
end

function CombatScene:update()
    playdate.graphics.clear(playdate.graphics.kColorClear)
    playdate.graphics.setBackgroundColor(playdate.graphics.kColorClear)

    if CombatScene.state == "generate_encouter" then
        CombatScene:generate_encounter()
        return
    end

    if CombatScene.state == "pre-combat" then
        CombatScene:animate_fight_logo()
        return
    end

    if CombatScene.state == "combat" then
        playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeFillWhite)
        player:update()
        current_enemy:update()
        ui_elements:update()
        playdate.graphics.drawText("Life: " .. player.life .. "/" .. player.max_life, 10, 190)
        playdate.graphics.drawText("Mana: " .. player.mana .. "/" .. player.max_mana, 10, 210)
    end
end

return CombatScene