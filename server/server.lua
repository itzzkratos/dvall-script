local config = {
    webhookURL = Config.webhookURL
}

RegisterCommand(Config.commandName, function(source, args, user)
    if not IsPlayerAceAllowed(source, 'command.dvall') then
            TriggerClientEvent('codem-notification', "You do not have permission to execute this command.", 5000, error, options)
        return
    end

    TriggerClientEvent('codem-notification', -1, "MASS DV, PLEASE GET INTO YOUR VEHICLES! (30 SECONDS)", 5000, info, options)
    Wait(15000)
    TriggerClientEvent('codem-notification', -1, "MASS DV, PLEASE GET INTO YOUR VEHICLES! (15 SECONDS)", 5000, info, options)
    Wait(15000)
    TriggerClientEvent('codem-notification', -1, "MASS DV COMPLETE!", 5000, info, options)
    Wait(1)
    TriggerClientEvent("wld:delallveh", -1)

    local playerName = GetPlayerName(source)
    local discordId = GetDiscordIdentifier(source)

    local mention = ("<@%s>"):format(discordId)

    local logEmbed = {
        {
            ["color"] = 16711680, 
            ["title"] = "Command Execution Log",
            ["fields"] = {
                { name = "Player", value = playerName, inline = true},
                { name = "Discord", value = mention, inline = true},
                { name = "Information", value = "```User Mass Dved```", inline = false},
                { name = "Timestamp", value = os.date("%Y-%m-%d %H:%M:%S"), inline = false}
            }
        }
    }

    local json = json or require('json')

    local PerformHttpRequest = PerformHttpRequest or function(url, cb, method, data, headers)
        PerformHttpRequest(url, cb, method, data, headers)
    end

    PerformHttpRequest(webhookURL, function(statusCode, text, headers) end, 'POST', json.encode({embeds = logEmbed}), { ['Content-Type'] = 'application/json' })

end, Config.restricCommand)

function GetDiscordIdentifier(player)
    local identifiers = GetPlayerIdentifiers(player)
    for _, identifier in ipairs(identifiers) do
        if string.match(identifier, "^discord:") then
            return string.sub(identifier, 9) 
        end
    end
    return nil
end 