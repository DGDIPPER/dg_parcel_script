local ox_inventory = exports.ox_inventory

RegisterNetEvent('parcel:giveRewards', function()
    local src = source

    -- remove parcel
    if not ox_inventory:RemoveItem(src, 'parcel', 1) then
        print('DEBUG: parcel not removed')
        return
    end

    -- how many rewards this parcel will give
    local rewardCount = math.random(Config.MinRewards, Config.MaxRewards)
    local totalGiven = 0

    -- repeat until enough rewards are given
    while totalGiven < rewardCount do
        for _, reward in ipairs(Config.Rewards) do

            -- stop if reached amount
            if totalGiven >= rewardCount then break end

            local roll = math.random(100)
            if roll <= reward.chance then
                local amount = math.random(reward.min, reward.max)
                ox_inventory:AddItem(src, reward.item, amount)
                totalGiven = totalGiven + 1
            end
        end
    end

    -- if absolutely nothing rolled, give 1 fallback reward
    if totalGiven == 0 then
        ox_inventory:AddItem(src, Config.Rewards[1].item, 1)
    end
end)
