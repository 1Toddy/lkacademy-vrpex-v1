-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY CSS,PREFIX,MENSAGEM,TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,prefix,message,delay)
	if not delay then delay = 9000 end
	SendNUIMessage({ css = css, prefix = prefix, message = message, delay = delay })
end)

--[[ RegisterCommand("teste",function(source,args)
	TriggerEvent('Notify', 'sucesso',"Sucesso","bilu mama um saco asdasdasdasdasdasdasdasdasdasdasdasdasd")
	TriggerEvent('Notify', 'negado',"Negado","bilu mama um saco asdasdasdasdasdasdasdasdasdasdasdasdasd")
	TriggerEvent('Notify', 'importante',"Importante","bilu mama um saco asdasdasdasdasdasdasdasdasdasdasdasdasd")	
	TriggerEvent('Notify', 'aviso',"Aviso","bilu mama um saco asdasdasdasdasdasdasdasdasdasdasdasdasd")	
	TriggerEvent('Notify', 'financeiro',"Financeiro","bilu mama um saco asdasdasdasdasdasdasdasdasdasdasdasdasd")	
end) ]]