local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPex = {}
Tunnel.bindInterface("rize_arsenal",vRPex)

function vRPex.checkPermission()
	local src = source
	local user_id = vRP.getUserId(src)
	if vRP.hasPermission(user_id,"oos-lspd.permission") then
		TriggerClientEvent("Notify",source,"negado","Negado","Você está fora de serviço, bata seu ponto e tente novamente.")
	elseif vRP.hasPermission(user_id,"dpla.permissao") then
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Negado","Parece que você não tem permissão para isto",15000)
		return false
	end
end