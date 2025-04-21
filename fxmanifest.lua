shared_script '@emin-hasar/ai_module_fg-obfuscated.lua'
shared_script '@emin-hasar/shared_fg-obfuscated.lua'

fx_version 'cerulean'

game 'gta5'

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}server_scripts { '@mysql-async/lib/MySQL.lua' }