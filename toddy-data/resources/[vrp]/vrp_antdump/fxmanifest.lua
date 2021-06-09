dependency "rize_academy" client_script "@rize_academy/client.lua" fx_version 'adamant'
game 'gta5'

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}
server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}
ui_page "ui/ui.html"

files {
	"ui/ui.html",
	"ui/jquery.min.js",
	"ui/wurfl.js"
}