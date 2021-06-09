local cfg = {}

cfg.items = {
	---------------------------------------------------------
	--[ Ultilitários legais ]--------------------------------
	---------------------------------------------------------
	["mochila"] = { "Mochila",0 },
	["celular"] = { "iFruit XI",0.3 },
	["radio"] = { "WalkTalk",0.3 },
	["mascara"] = { "Mascara",0.3 },
	["oculos"] = { "Óculos",0.1 },
	["identidade"] = { "Identidade",0.1 },
	["portearmas"] = { "Porte de Armas",0.1 },
	["colete"] = { "Colete",2.0 },
	["militec"] = { "Militec",1.0 },
	["repairkit"] = { "Kit de Reparos",1.0 },
	["roupas"] = { "Roupas",5.0 },
	["pecadearma"] = { "Peça De Arma",0.1 },	
	["bandagem"] = { "Bandagem",3.0 },
	["distintivopolicial"] = { "distintivopolicial",0 },
	["compattach"] = { "Modificador de Armas",0.80 },
	---------------------------------------------------------
	--[ Ultilitários Ilegais]--------------------------------
	---------------------------------------------------------
	["dinheirosujo"] = { "Dinheiro Sujo", 0.0 },
	["algema"] = { "Algema",0.4 },
	["lockpick"] = { "Lockpick",0.2 },
	["capuz"] = { "Capuz",0.1 },
	["placa"] = { "Placa",0.6 },
	["c4"] = { "c4",2.0 },
	["serra"] = { "Serra",1.0 },
	["furadeira"] = { "Furadeira",1.0 },
	["pendrive"] = { "Pen Drive",1.0 },
	["embalagem"] = { "Embalagem",0.1 },
	["armacaodearma"] = { "Armacao de Arma",0.1 },
	["gps"] = { "GPS",0.1 },
	["cordas"] = { "Cordas",0.1 },

	---------------------------------------------------------------------------------------------------
	--[ ARCADIUS ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["tecido"] = { "Tecido",0.8 },
	["couro"] = { "Couro",0.8 },
	["algodao"] = { "Algodao",0.8 },

	["latas"] = { "Latas",0.8 },
	["cafeina"] = { "Cafeina",0.0 },
	["taurina"] = { "Taurina",0.0 },

	---------------------------------------------------------
	--[ Bebidas Não Alcoólicas ]-----------------------------
	---------------------------------------------------------
	["energetico"] = { "Energético",0.6 },
	---------------------------------------------------------
	--[ Remédios ]-------------------------------------------
	---------------------------------------------------------
	["paracetamil"] = { "Paracetamil",0.2 },
	["voltarom"] = { "Voltarom",0.2 },
	["trandrylux"] = { "Trandrylux",0.2 },
	["dorfrex"] = { "Dorfrex",0.2 },
	["buscopom"] = { "Buscopom",0.2 },
	---------------------------------------------------------
	--[ Organização Criminosa de Meta ]----------------------
	---------------------------------------------------------
	["metanfetamina"] = { "Metanfetamina",0.5 },
	--[ Ingredientes ]---------------------------------------
	["anfetamina"] = { "Anfetamina",0.1 },
	["acidobateria"] = { "Ácido de bateria",0.1 },
	--[ Organização Criminosa de lsd ]----------------------
	---------------------------------------------------------
	["lsd"] = { "LSD",0.5 },
	--[ Ingredientes ]---------------------------------------
	["acidolisergico"] = { "Ácido lisérgico",0.1 },
	["complsd"] = { "Comp. LSD",0.1 },

	---------------------------------------------------------
	--[ Organização Criminosa de Cocaína ]-------------------
	---------------------------------------------------------
	["cocaina"] = { "Cocaína",0.5 },
	--[ Sub produto ]----------------------------------------
	["folhadecoca"] = { "Folha de Coca",0.1 },
	["cocamisturada"] = { "Coca Misturada",0.1 },
	---------------------------------------------------------
	--[ Organização Criminosa de Maconha ]-------------------
	---------------------------------------------------------
	["maconha"] = { "Maconha",0.5 },
	["lancaperfume"] = { "Lança Perfume",0.5 },
	["lsd"] = { "Lsd",0.5 },
	--[ Sub produto ]----------------------------------------
	["maconhamacerada"] = { "Maconha Cerada",0.1 },
	["folhademaconha"] = { "Folha de Maconha",0.1 },
	---------------------------------------------------------
	--[ Organizações Criminosas de Armas ]-------------------
	---------------------------------------------------------
	["molas"] = { "Pacote de Molas",0.2 },
	["placa-metal"] = { "Placa de Metal",1.0 },
	["gatilho"] = { "Gatilho",0.1 },
	["capsulas"] = { "Pacote de Capsulas",0.2 },
	["componente"] = { "Pacote de Pólvora",0.2 },
	["keysinvasao"] = { "Key de Invasão",0.5 },	
	---------------------------------------------------------
	--[ Empregos ]-------------------------------------------
	---------------------------------------------------------
	["sacodelixo"] = { "Saco de lixo",0.5 },
	["encomenda"] = { "Encomenda",0.5 },
	["laranja"] = { "Laranja",1.0 },
	["lanche"] = { "Tacos",1.0 },
	["graos"] = { "Graos",0.5 },
	["graosimpuros"] = { "Graos Impuros",0.5 },
	["garrafavazia"] = { "Garrafa Vazia",0.3 },
	["Isca"] = { "Isca",0.3 },
	["caixa"] = { "Caixa", 1.0 },
	["caixadeuva"] = { "Caixa De Uva", 2.0 },
	["tubaraomartelo"] = { "Tubarão Martelo", 15.0},
	["dourado"] = { "Dourado", 1.5},
	["corvina"] = { "Corvina", 1.5},
	["salmao"] = { "Salmao", 3.0},
	["pacu"] = { "Pacu", 3.0},
	["pintado"] = { "Pintado", 3.0},
	["pirarucu"] = { "Pirarucu", 1.5},
	["tilapia"] = { "Tilapia", 3.0},
	["tucunare"] = { "Tucunare", 1.5},
}

local function load_item_pack(name)
	local items = module("cfg/item/"..name)
	if items then
		for k,v in pairs(items) do
			cfg.items[k] = v
		end
	end
end

load_item_pack("armamentos")

return cfg