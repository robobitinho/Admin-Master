-- Definição de ranks e permissões
local ranks = {
    ["owner"] = {
        name = "Owner",
        color = "#FF0000",
        permissions = {"all"}
    },
    ["admin"] = {
        name = "Admin",
        color = "#00FF00",
        permissions = {"kick", "ban", "give"}
    },
    ["moderator"] = {
        name = "Moderator",
        color = "#0000FF",
        permissions = {"kick", "mute"}
    },
    ["vip"] = {
        name = "VIP",
        color = "#FFFF00",
        permissions = {"fly"}
    },
    ["player"] = {
        name = "Player",
        color = "#FFFFFF",
        permissions = {}
    },
}

-- Função para verificar permissões
local function has_permission(player_name, permission)
    local privs = minetest.get_player_privs(player_name)
    local rank = privs.rank or "player"  -- Garantir que o rank seja 'player' se não estiver definido
    local perms = ranks[rank].permissions
    return table.contains(perms, permission) or table.contains(perms, "all")
end

-- Função para listar os ranks disponíveis
local function list_ranks()
    local rank_list = {}
    for rank_name, rank_data in pairs(ranks) do
        table.insert(rank_list, rank_name .. " (" .. rank_data.name .. ")")
    end
    return table.concat(rank_list, ", ")
end

return {
    ranks = ranks,
    has_permission = has_permission,
    list_ranks = list_ranks
}
