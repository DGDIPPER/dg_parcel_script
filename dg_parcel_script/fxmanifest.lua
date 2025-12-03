fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'DGDIPPER'
description 'Parcel reward script for Qbox + ox_inventory'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config/config.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}
