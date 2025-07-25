local chicken_enemy = {level = 1, hp = 20, min_damage = 5, max_damage = 7, defense = 0, image = Globals.assets.sprites.chicken_enemy}

Enemies = {
    common = {chicken_enemy},
    bosses = {},
}

function Enemies:get_random_enemy_by_dungeon_floor(dungeon_floor)
    local monsters = {}
    for index = 1, #Enemies.common do
        if Enemies.common[index].level == dungeon_floor then table.insert(monsters, Enemies.common[index]) end
    end
    local max = table.getsize(monsters)
    local randomIndex = math.random(1, max)
    return Enemies.common[randomIndex]
end

return Enemies