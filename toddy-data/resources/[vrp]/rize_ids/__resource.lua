dependency "rize_academy" client_script "@rize_academy/client.lua" description "vrp_names"

dependency "vrp"

client_scripts {
    "@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
	"server.lua"
}
