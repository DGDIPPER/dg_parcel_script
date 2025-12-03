RegisterNetEvent('parcel:useParcel', function()
    local ped = PlayerPedId()

    -- Load box model
    local model = `prop_cs_cardbox_01`
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end

    -- Create box and attach to hand
    local box = CreateObject(model, 0, 0, 0, true, true, true)
    AttachEntityToEntity(
        box,
        ped,
        GetPedBoneIndex(ped, 28422), -- right hand
        0.03, 0.02, -0.15,            -- offset
        0.0, 0.0, 90.0,               -- rotation
        true, true, false, true, 1, true
    )

    ---------------------------------------------------
    -- 🔵 Start HOLD animation (same as before)
    ---------------------------------------------------
    RequestAnimDict('anim@heists@box_carry@')
    while not HasAnimDictLoaded('anim@heists@box_carry@') do Wait(10) end
    TaskPlayAnim(ped, 'anim@heists@box_carry@', 'idle', 5.0, -5.0, -1, 49, 0, false, false, false)


    ---------------------------------------------------
    -- 🔵 OX LIB progress bar (NO animation override)
    ---------------------------------------------------
    lib.progressBar({
        duration = 3000,
        label = 'Opening Parcel...',
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true,
            car = true,
            combat = true
        }
    })


    ---------------------------------------------------
    -- 🔵 Play your original OPENING animation
    ---------------------------------------------------
    RequestAnimDict('mp_common')
    while not HasAnimDictLoaded('mp_common') do Wait(10) end
    TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, 1500, 49, 0, false, false, false)
    Wait(1600)


    ---------------------------------------------------
    -- Cleanup
    ---------------------------------------------------
    ClearPedTasks(ped)
    DeleteObject(box)

    -- Server reward
    TriggerServerEvent('parcel:giveRewards')
end)
