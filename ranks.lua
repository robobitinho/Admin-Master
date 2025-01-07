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
    local rank = minetest.get_player_privs(player_name).rank or "player"
    local perms = ranks[rank].permissions
    return table.contains(perms, permission) or table.contains(perms, "all")
end

return {
    ranks = ranks,
    has_permission = has_permission
}
