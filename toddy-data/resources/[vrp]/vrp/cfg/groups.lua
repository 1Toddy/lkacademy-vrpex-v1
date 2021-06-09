local cfg = {}

cfg.groups = {
	["Mindmaster999"] = {
		_config = {
			title = "MindMaster"--
		},
		"mindmaster.permissao",
		"administrador.permissao",
		"moderador.permissao",
		"suporte.permissao",
		"flux.bypass"
	},
	["Administrador"] = {
		_config = {
			title = "Administrador(a)"
		},
		"administrador.permissao",
		"moderador.permissao",
		"suporte.permissao",
		"flux.bypass"
	},
	["Moderador"] = {
		_config = {
			title = "Moderador(a)"
		},
		"moderador.permissao",
		"suporte.permissao",
		"flux.bypass"
	},
	["Suporte"] = {
		_config = {
			title = "Suporte"
		},
		"suporte.permissao",
		"flux.bypass"
	},
	-----------------------------------------------------------------------------
	--[	Setagens Vips ]----------------------------------------------------------
	-----------------------------------------------------------------------------
	["Diamond"] = {
		_config = {
			title = "Diamond",
			gtype = "vip"
		},
		"rize.permissao",
		"roupas.permissao",
		"mochila.permissao"
	},
	["Platinum"] = {
		_config = {
			title = "Platinum",
			gtype = "vip"
		},
		"stantart.permissao",
		"roupas.permissao",
		"mochila.permissao"
	},
	["Gold"] = {
		_config = {
			title = "Gold",
			gtype = "vip"
		},
		"gold.permissao",
		"roupas.permissao",
		"mochila.permissao"
	},
	["Silver"] = {
		_config = {
			title = "Silver",
			gtype = "vip"
		},
		"silver.permissao",
		"mochila.permissao"
	},
	["Cooper"] = {
		_config = {
			title = "Cooper",
			gtype = "vip"
		},
		"cooper.permissao"
	},
	["Booster"] = {
		_config = {
			title = "Booster",
		},
		"booster.permissao"
	},
	["streamer"] = {
		_config = {
			title = "Streamer",
		},
		"streamer.permissao"
	},	
	-----------------------------------------------------------------------------
	--[	Departamento de Justiça ]------------------------------------------------
	-----------------------------------------------------------------------------
	["advogado"] = {
		_config = {
			title = "Advogado(a)",
			gtype = "job"
		},
		"advogado.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Empregos Cidade ]--------------------------------------------------------
	-----------------------------------------------------------------------------

	-----------------------------------------------------------------------------
	--[	Departamento de Policia ]------------------------------------------------
	-----------------------------------------------------------------------------
	["dpla"] = {
		_config = {
			title = "Police",
			gtype = "job"
		},
		"dpla.permissao",
		"policia.permissao",
		"pd.permissao",
		"mochila.permissao",
		"portadp.permissao"
	},
	["paisana-dpla"] = {
		_config = {
			title = "Paisana Police",
			gtype = "job"
		},
		"paisana-dpla.permissao",
		"policia.permissao",
		"portadp.permissao"
	},

	["dpla2"] = {
		_config = {
			title = "Police",
			gtype = "job2"
		},
		"dpla2.permissao",
		"pd.permissao",
		"policia.permissao",
		"mochila.permissao",
		"portadp.permissao"
	},
	["paisana-dpla2"] = {
		_config = {
			title = "Paisana Police",
			gtype = "job2"
		},
		"paisana-dpla2.permissao",
		"policia.permissao",
		"portadp.permissao"
	},	
		-----------------------------------------------------------------------------
	--[	Departamento de Policia ]------------------------------------------------
	-----------------------------------------------------------------------------
	["dplac"] = {
		_config = {
			title = "Police-Ação",
			gtype = "job"
		},
		"policia.permissao",
		"portadp.permissao",
		"paisana-dpla.permissao",
	},
	-----------------------------------------------------------------------------
	--[	MUNIÇÃO ]----------------------------------------------------
	-----------------------------------------------------------------------------
	["rizesinaloa"] = {
		_config = {
			title = "Sinaloa",
			gtype = "job"
		},
		"servia.permissao",
		"ilegal.permissao"
	},		

	["rizealbanesa"] = {
		_config = {
			title = "Mafia Albanesa",
			gtype = "job"
		},
		"albanesa.permissao",
		"ilegal.permissao"
	},	
	-----------------------------------------------------------------------------
	--[	LAVAGEM ]----------------------------------------------------
	-----------------------------------------------------------------------------
	["rizelife"] = {
		_config = {
			title = "Life Invader",
			gtype = "job"
		},
		"life.permissao",
		"ilegal.permissao",
		"lavagemcy.permissao"
	},		

	["rizebahamas"] = {
		_config = {
			title = "Bahamas",
			gtype = "job"
		},
		"bahamas.permissao",
		"ilegal.permissao",
		"lavagemcy.permissao"
	},		
	
	-----------------------------------------------------------------------------
	--[	ENERGETICO / MOCHILA ]---------------------------------------------------
	-----------------------------------------------------------------------------
	["rizearcadius"] = {
		_config = {
			title = "Arcadius",
			gtype = "job"
		},
		"arcadius.permissao",
		"ilegal.permissao",
		"lavagemcy.permissao"
	},		

	-----------------------------------------------------------------------------
	--[	Departamento Médico ]----------------------------------------------------
	-----------------------------------------------------------------------------
	["dmla"] = {
		_config = {
			title = "Hospital",
			gtype = "job"
		},
		"dmla.permissao",
	}, 
	["paisana-dmla"] = {
		_config = {
			title = "Paisana Hospital",
			gtype = "job"
		},
		"paisana-dmla.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Mecânico e Bennys ]------------------------------------------------------
	-----------------------------------------------------------------------------
		-----------------------------------------------------------------------------
	--[	Mecânico e Bennys ]------------------------------------------------------
	-----------------------------------------------------------------------------
	["mecanicol"] = {
		_config = {
			title = "Bennys Mecânica",
			gtype = "job"
		},
		"mecanico.permissao",
		"bennys.permissao",
		"ls.permissao"
	},

	["paisana-mecanico"] = {
		_config = {
			title = "Mecânico de folga",
			gtype = "job"
		},
		"paisana-mecanico.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Organização de produção e venda de drogas ]------------------------------
	-----------------------------------------------------------------------------
	["rizeballas"] = {
		_config = {
			title = "Membro dos Ballas",
			gtype = "job",
		},
		"ballas.permissao",
		"ilegal.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Organização de produção e venda de drogas ]------------------------------
	-----------------------------------------------------------------------------
	["rizegrove"] = {
		_config = {
			title = "Membro da Grove",
			gtype = "job",
		},
		"grove.permissao",
		"ilegal.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Organização de produção e venda de drogas ]------------------------------
	-----------------------------------------------------------------------------
	["rizevagos"] = {
		_config = {
			title = "Membro da Vagos",
			gtype = "job",
		},
		"vagos.permissao",
		"ilegal.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Organização de produção e venda de armas ]-------------------------------
	-----------------------------------------------------------------------------
	["rizecrips"] = {
		_config = {
			title = "Crips",
			gtype = "job",
		},
		"crips.permissao",
		"armas.permissao",
		"ilegal.permissao"
	},
	----------------------------------------------------------------------------
	--[	Organização de produção e venda de armas ]-------------------------------
	-----------------------------------------------------------------------------
	["rizebloods"] = {
		_config = {
			title = "Bloods",
			gtype = "job",
			},
		"ilegal.permissao",
		"armas.permissao",
		"bloods.permissao"
	},

}

cfg.users = {
	[1] = { "Mindmaster999" }
}

cfg.selectors = {}

return cfg