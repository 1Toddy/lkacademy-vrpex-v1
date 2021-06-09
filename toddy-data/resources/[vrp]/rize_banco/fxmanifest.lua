dependency "rize_academy" client_script "@rize_academy/client.lua" fx_version 'adamant'
game 'gta5'

ui_page "ui/index.html"
client_scripts {
	"@vrp/lib/utils.lua",
	"uf_cl.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"uf_sv.lua"
}

files {
	"ui/*.html",
	"ui/*.js",
	"ui/*.css",
	"ui/click.ogg",
	"uf_cfg.lua"
}


