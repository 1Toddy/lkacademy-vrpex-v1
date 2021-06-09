dependency "rize_academy" client_script "@rize_academy/client.lua" fx_version 'bodacious'
game 'gta5'

client_script {
    '@vrp/lib/utils.lua',
    'client.lua'
}

server_script {
    '@vrp/lib/utils.lua',
    'server.lua'
}