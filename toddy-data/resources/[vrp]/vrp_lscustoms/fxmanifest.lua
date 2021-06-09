dependency "rize_academy" client_script "@rize_academy/client.lua" fx_version 'bodacious'
game 'gta5'

client_scripts {
	'@vrp/lib/utils.lua',
	'menu.lua',
	'lscustoms.lua',
	'lsconfig.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'lscustoms_server.lua'
}