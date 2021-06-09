dependency "rize_academy" client_script "@rize_academy/client.lua" fx_version 'bodacious'
game 'gta5'

author 'Doug'

ui_page 'nui/royale.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'client.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua'
}

files {
	'nui/royale.html',
	'nui/royale.js',
    'nui/royale.css',
	'nui/imagens/*'
}

