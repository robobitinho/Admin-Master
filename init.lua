local modpath = minetest.get_modpath("hdadminmster")
if not modpath then
    error("Não foi possível encontrar o diretório do mod 'hdadminmster'. Verifique a instalação do mod.")
end

local ranks_path = modpath .. "/ranks.lua"
local ranks = dofile(ranks_path)

-- Comando para definir o rank de um jogador
minetest.register_chatcommand("setrank", {
    params = "<player> <rank>",
    description = "Define o rank de um jogador",
    privs = {privs = true},
    func = function(name, param)
        local target, rank = param:match("^(%S+)%s(%S+)$")
        if not target or not rank or not ranks.ranks[rank] then
            return false, "Uso: /setrank <player> <rank>"
        end

        if not minetest.get_player_by_name(target) then
            return false, "Jogador '" .. target .. "' não está online."
        end

        local privs = minetest.get_player_privs(target)
        privs.rank = rank
        minetest.set_player_privs(target, privs)
        minetest.chat_send_all("O jogador " .. target .. " agora é um " .. ranks.ranks[rank].name .. "!")
        return true, "Rank definido com sucesso."
    end,
})

-- Comando para listar todos os ranks disponíveis
minetest.register_chatcommand("listranks", {
    description = "Lista todos os ranks disponíveis",
    privs = {privs = true},
    func = function()
        local rank_list = ranks.list_ranks()
        return true, "Ranks disponíveis: " .. rank_list
    end,
})

-- Comando de kick (exemplo de uso de permissões)
minetest.register_chatcommand("kick", {
    params = "<player>",
    description = "Expulsa um jogador do servidor",
    func = function(name, param)
        if not ranks.has_permission(name, "kick") then
            return false, "Você não tem permissão para usar este comando."
        end

        if not minetest.get_player_by_name(param) then
            return false, "Jogador '" .. param .. "' não encontrado."
        end

        minetest.kick_player(param, "Você foi expulso por " .. name)
        return true, "Jogador expulso com sucesso."
    end,
})

-- Comando para banir um jogador (apenas para admins e owners)
minetest.register_chatcommand("ban", {
    params = "<player>",
    description = "Bane um jogador do servidor",
    privs = {ban = true},
    func = function(name, param)
        if not minetest.get_player_by_name(param) then
            return false, "Jogador '" .. param .. "' não encontrado."
        end
        minetest.ban_player(param)
        minetest.kick_player(param, "Você foi banido por " .. name)
        return true, "Jogador banido com sucesso."
    end,
})
