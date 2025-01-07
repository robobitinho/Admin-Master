local ranks = dofile(minetest.get_modpath("admin_ranks") .. "/ranks.lua")

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
            return false, "Jogador não encontrado."
        end

        local privs = minetest.get_player_privs(target)
        privs.rank = rank
        minetest.set_player_privs(target, privs)
        minetest.chat_send_all("O jogador " .. target .. " agora é um " .. ranks.ranks[rank].name .. "!")
        return true, "Rank definido com sucesso."
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
            return false, "Jogador não encontrado."
        end

        minetest.kick_player(param, "Você foi expulso por " .. name)
        return true, "Jogador expulso com sucesso."
    end,
})
