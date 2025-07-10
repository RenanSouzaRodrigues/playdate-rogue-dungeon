Globals = {}

Globals.debug = true;

Globals.assets = {
    images = { 
        studio_logo = "assets/images/dsl_playdate.png",
        arena = "assets/images/arena.png"
    },
    sprites = { 
        player = "assets/sprites/player_placeholder.png",
        chicken_enemy = "assets/sprites/enemy_bird_placeholder.png",
        attack_button_black = "assets/sprites/attack_button_black.png",
        attack_button_white = "assets/sprites/attack_button_white.png",
        magic_button_black = "assets/sprites/magic_button_black.png",
        magic_button_white = "assets/sprites/magic_button_white.png",
        items_button_black = "assets/sprites/items_button_black.png",
        items_button_white = "assets/sprites/items_button_white.png",
        seller = "assets/sprites/seller.png"
    },
    musics = {
        combat_song = "assets/sounds/combat_song"
    },
    sounds = {
        logo_sound = "assets/sounds/logo_sound"
    }
}

Globals.game_values = {
    logo_duration = 2,
    half_X = 400/2,
    half_Y = 240/2,
    idle_max_scale = 1,
    idle_min_scale = 0.92,
    sprite_botton_middle = {x = 0.5, y = 1},
    button_default_scale = 1.2,
    button_active_scale = 2,
}

function Globals:calculate_idle(type)
    local speed_value
    if type == "player" then speed_value = 4 else speed_value = 5 end
    
    -- https://www.youtube.com/watch?v=Qsv4_xOkh4M
    return
        ((Globals.game_values.idle_max_scale + Globals.game_values.idle_min_scale) / 2) +
        (((Globals.game_values.idle_max_scale - Globals.game_values.idle_min_scale) / 2) *
        math.sin(playdate.getElapsedTime() * speed_value))
end