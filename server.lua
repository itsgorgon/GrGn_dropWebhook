--[[
#######################################################################
###			WEBHOOK PLAYER DROPPED SIMPLES PARA BASES vRPEX. 
###  ~~~~ !!! SCRIPT TOTALMENTE GRATUITO, PROIBIDO REVENDA !!! ~~~~
###				CRIADO POR: function Gorgon()#6534
### 		  (presto suporte apenas no discord)
#######################################################################
]]

-----------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- INFOs WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped",function(reason)
	local source = source
	local user_id = vRP.getUserId(source)
	local steam = vRP.getSteam(source)
	if not reason then reason = "Sem explicações" end
	local ip = GetPlayerEndpoint(source)
	local identity = vRP.getUserIdentity(user_id)
	local datatable = vRP.getUserDataTable(user_id)

	if user_id then
		if gxrgxn["base"] == "creative" then
			local idade = identity.age
			if idade == nil or idade == 0 then idade = "Sem registro" end
			local carteira = vRP.getInventoryItemAlls(user_id, "dollars")
			local multas = vRP.getFines(user_id)
			local totmult = 0
			local paypal = ""
			if gxrgxn["paypal"] then
				if gxrgxn["funcpaypal"] ~= nil then
					print('\27[31mDESATIVE O PAYPAL, AINDA ESTÁ EM TESTES...')
				else
					print('\27[31mERRO NA FUNÇÃO DO PAYPAL!')
				end
			else
				paypal = "Sem paypal"
			end
		
			-- MULTAS
			if multas[1] then
				for k,v in pairs(multas) do
					if v["price"] then
						totmult = totmult + v["price"]
					end
				end
			end

			-- INVENTARIO
			local inventario = vRP.getInventory(user_id)
			local itens = {}
			if json.encode(inventario) ~= "{}" then
				for k,v in pairs(inventario) do
					table.insert(itens, "> "..v["amount"].."x "..vRP.itemNameList(v["item"]))
				end
				itens = table.concat(itens, "\n")
			else
				itens = "> :x:: Nenhum item no inventário."
			end

			-- ARMAMENTOS
			local armas = {}
			if gxrgxn["armamentos"] then
				if gxrgxn["weaps"] then
					if json.encode(datatable["weaps"]) ~= "[]" then
						for k,v in pairs(datatable["weaps"]) do
							table.insert(armas, "> :gun:: "..vRP.itemNameList(k).." com x"..v["ammo"].." munições.")
						end
						armas = table.concat(armas, "\n")
					else
						armas = "> :x:: Nenhum armamento equipado!"
					end
				else

					local getarmas = vRP.getWeaponsId(user_id)

					if getarmas[1] then
						
						for k,v in pairs(getarmas) do
							table.insert(armas, "> :gun:: "..vRP.itemNameList(v["weapon"]).." x"..v["ammo"].." munições.")
						end

						armas = table.concat(armas, "\n")
						
					else
						armas = "> :x:: Nenhum armamento equipado!"
					end
				end
			else
				armas = "> :x:: *~SISTEMA DESABILITADO~*"
			end

			-- CASAS 
			local myHomes = vRP.query("vRP/get_homeuserid",{ user_id = parseInt(user_id) })
			local casas = {}
			if parseInt(#myHomes) >= 1 then
				for k,v in pairs(myHomes) do
					table.insert(casas, "> :house:: "..v["home"])
				end
				casas = table.concat(casas, "\n")
			else
				casas = "> :x:: Não possui nenhuma propriedade."
			end
			-- CARROS
			local vehicle = vRP.query("vRP/get_vehicle",{ user_id = parseInt(user_id) })
			local carros = {}
			if vehicle[1] then
				for k,v in pairs(vehicle) do
					table.insert(carros, "> :oncoming_automobile:: " ..vRP.vehicleName(v["vehicle"]))
				end
				carros = table.concat(carros, "\n")
			else
				carros = "> :x:: Não possui nenhum veículo na garagem."
			end

			-- GRUPOS
			local perms = vRP.query("vRP/get_perm",{ user_id = parseInt(user_id)})
			local grupos = {}
			if perms[1] then
				for k,v in pairs(perms) do
					if v["permiss"] then
						table.insert(grupos, "> :pushpin:: "..v["permiss"])
					end
				end
				grupos = table.concat(grupos, "\n")
			else
				grupos = "> :x:: Sem grupos."
			end
			-- PREMIUM
			local consult = vRP.getInfos(identity.steam)
			local vip = vRP.getPremium(user_id)
			if vip then vip = "> :green_circle:: Ativo por: "..vRP.getTimersDc(parseInt(86400*consult[1].predays-(os.time()-consult[1].premium))) else vip = "> :red_circle:: Desativado." end
		
			-- EXTRAS
			local pena = 0
			if identity.prison >= 1 then
				pena = identity.prison.." meses/serviços."
			else
				pena = "Nenhuma penalidade à cumprir."
			end

				PerformHttpRequest(gxrgxn["webhook"], function(err, text, headers) end, 'POST', json.encode({avatar_url = gxrgxn["avatarurl"],username = gxrgxn["username"],
					embeds = {
						{ 	------------------------------------------------------------
							title = "JOGADOR DESCONECTADO DA CIDADE:					\n⠀",
							thumbnail = {
								url = gxrgxn["imgurl"]
							},
							fields = {
								{name = "**• INFORMAÇÕES PESSOAIS:**",
									value = "> :detective:: **ID:** "..user_id.."\n> :pencil:: **NOME:** "..identity.name.." "..identity.name2.."\n> :underage:: **IDADE:** "..idade.."\n> :card_index:: **RG:** "..identity.registration
								},
								{name = "**• INFORMAÇÕES MONETARIAS:**",
									value = "> :money_with_wings:: **CARTEIRA:** $"..vRP.format(carteira).."\n> :moneybag:: **BANCO:** $"..vRP.format(identity.bank).."\n> :parking:: **PAYPAL:** "..paypal.."\n> :bookmark_tabs:: **MULTAS:** $"..totmult
								},
								{name = "**• INVENTÁRIO:**",value = itens},{name = "**• ARMAS EQUIPADAS:**",value = armas},{name = "**• RESIDÊNCIAS:**",value = casas},{name = "**• VEÍCULOS:**",value = carros},
								{name = "**• SETAGENS:**",value = grupos},{name = "**• PREMIUM:**",value = vip},{name = "**• INFORMAÇÕES EXTRAS:**",value = "> **TEMPO RESTANTE NA PRISÃO:** "..pena.."\n> **IP:** "..ip.."\n> **STEAMHEX:** "..identity.steam.."\n> **__MOTIVO QUIT:__** "..reason},
							},
							footer = { 
								text = os.date("%d/%m/%Y | %H:%M:%S").." - Dev: function Gorgon()#6534",
								icon_url = "https://static.thenounproject.com/png/678156-200.png"
							},
							color = gxrgxn["corembed"]
						}
					}
				}), { ['Content-Type'] = 'application/json' })
				
		else
			local idade = identity.age
			if idade == nil or idade == 0 then idade = "Sem registro" end
			local banco = vRP.getBankMoney(user_id)
			local carteira = vRP.getInventoryItemAmount(user_id,"dinheiro")
			local multas = vRP.getUData(user_id,"vRP:multas")
			local mymultas = json.decode(multas) or 0
			local paypal = "Paypal"
		
			-- INVENTARIO
			local inventario = vRP.getInventory(user_id)
			local itens = {}
			local haitens = false
			for k,v in pairs(inventario) do
				if k then
					haitens = true
				end
			end
			if haitens then
				for k,v in pairs(inventario) do
					table.insert(itens, "> "..v["amount"].."x "..vRP.itemNameList(k))
				end
				itens = table.concat(itens, "\n")
			else
				itens = "> :x:: Nenhum item no inventário."
			end

		
			-- ARMAMENTOS
			local armas = {}
			if gxrgxn["armamentos"] then
				local haarmas = false
				for k,v in pairs(datatable["weapons"]) do
					if k then
						haarmas = true
					end
				end
				if haarmas then
					for k,v in pairs(datatable["weapons"]) do
						if gxrgxn["base"] == "zirixv3" then
							table.insert(armas, "> :gun:: "..vRP.itemNameList("wbody"..k).." com x"..v["ammo"].." munições.")
						else
							table.insert(armas, "> :gun:: "..vRP.itemNameList("wbody|"..k).." com x"..v["ammo"].." munições.")
						end
					end
					armas = table.concat(armas, "\n")
				else
					armas = "> :x:: Nenhum armamento equipado!"
				end
			else
				armas = "> :x:: *~SISTEMA DESABILITADO~*"
			end

			-- CASAS 
			local myHomes = vRP.query(gxrgxn["queryhomes"],{ user_id = parseInt(user_id) })
			local casas = {}
			if parseInt(#myHomes) >= 1 then
				for k,v in pairs(myHomes) do
					table.insert(casas, "> :house:: "..v["home"])
				end
				casas = table.concat(casas, "\n")
			else
				casas = "> :x:: Não possui nenhuma propriedade."
			end

			-- CARROS
			local vehicle = vRP.query(gxrgxn["querygarages"],{ user_id = parseInt(user_id) })
			local carros = {}
			if vehicle[1] then
				for k,v in pairs(vehicle) do
					table.insert(carros, "> :oncoming_automobile:: " ..vRP.vehicleName(v["vehicle"]).." ("..vRP.vehicleType(v["vehicle"])..")")
				end
				carros = table.concat(carros, "\n")
			else
				carros = "> :x:: Não possui nenhum veículo na garagem."
			end

			-- GRUPOS
			local grupos = {}
			local hagrupos = false
			for k,v in pairs(datatable["groups"]) do
				if k then
					hagrupos = true
				end
			end
			if hagrupos then
				for k,v in pairs(datatable["groups"]) do
					if k then
						table.insert(grupos, "> :pushpin:: "..k)
					end
				end
				grupos = table.concat(grupos, "\n")
			else
				grupos = "> :x:: Sem grupos."
			end
			-- PREMIUM
			local pass = ""
			local vip
			if vRP.hasPermission(user_id,"ultimate.permissao") then
				pass = "Ultimate"
			elseif vRP.hasPermission(user_id,"platina.permissao") then
				pass = "Platina"
			elseif vRP.hasPermission(user_id,"ouro.permissao") then
				pass = "Ouro"
			elseif vRP.hasPermission(user_id,"standard.permissao") then
				pass = "Standard"
			end
			if pass ~= "" then vip = "> :green_circle:: VIP ATIVO: "..pass else vip = "> :red_circle:: Desativado." end
		
			-- EXTRAS
			
			local pena = 0
			local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
			if value ~= nil and value ~= "" and value >= 1 then
				pena = value.." meses/serviços."
			else
				pena = "Nenhuma penalidade à cumprir."
			end

			PerformHttpRequest(gxrgxn["webhook"], function(err, text, headers) end, 'POST', json.encode({avatar_url = gxrgxn["avatarurl"],username = gxrgxn["username"],
				embeds = {
					{ 	------------------------------------------------------------
						title = "JOGADOR DESCONECTADO DA CIDADE:					\n⠀",
						thumbnail = {
							url = gxrgxn["imgurl"]
						},
						fields = {
							{name = "**• INFORMAÇÕES PESSOAIS:**",
								value = "> :detective:: **ID:** "..user_id.."\n> :pencil:: **NOME:** "..identity.name.." "..identity.firstname.."\n> :underage:: **IDADE:** "..idade.."\n> :card_index:: **RG:** "..identity.registration
							},
							{name = "**• INFORMAÇÕES MONETARIAS:**",
								value = "> :money_with_wings:: **CARTEIRA:** $"..vRP.format(carteira).."\n> :moneybag:: **BANCO:** $"..vRP.format(banco).."\n> :parking:: **PAYPAL:** "..paypal.."\n> :bookmark_tabs:: **MULTAS:** $"..vRP.format(mymultas)
							},
							{name = "**• INVENTÁRIO:**",value = itens},{name = "**• ARMAS EQUIPADAS:**",value = armas},{name = "**• RESIDÊNCIAS:**",value = casas},{name = "**• VEÍCULOS:**",value = carros},
							{name = "**• SETAGENS:**",value = grupos},{name = "**• PREMIUM:**",value = vip},{name = "**• INFORMAÇÕES EXTRAS:**",value = "> **TEMPO RESTANTE NA PRISÃO:** "..pena.."\n> **IP:** "..ip.."\n> **STEAMHEX:** "..steam.."\n> **__MOTIVO QUIT:__** "..reason},
						},
						footer = { 
							text = os.date("%d/%m/%Y | %H:%M:%S").." - Dev: function Gorgon()#6534",
							icon_url = "https://static.thenounproject.com/png/678156-200.png"
						},
						color = gxrgxn["corembed"]
					}
				}
			}), { ['Content-Type'] = 'application/json' })
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GET TIMERS DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getTimersDc(seconds)
	local days = math.floor(seconds/86400)
	seconds = seconds - days * 86400
	local hours = math.floor(seconds/3600)
	seconds = seconds - hours * 3600
	local minutes = math.floor(seconds/60)
	seconds = seconds - minutes * 60

	if days > 0 then
		return string.format("**%d Dias**, **%d Horas**, **%d Minutos** e **%d Segundos**",days,hours,minutes,seconds)
	elseif hours > 0 then
		return string.format("**%d Horas**, **%d Minutos** e **%d Segundos**",hours,minutes,seconds)
	elseif minutes > 0 then
		return string.format("**%d Minutos** e **%d Segundos**",minutes,seconds)
	elseif seconds > 0 then
		return string.format("**%d Segundos**",seconds)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ALL ITENS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getInventoryItemAlls(user_id,idname)
	local data = vRP.getInventory(user_id)
	if data then
		local soma = 0
		for k,v in pairs(data) do
			for e, d in pairs(data[k]) do
				if d == idname then
					soma = soma + data[k]["amount"]
				end
			end
		end
		return parseInt(soma)
	end
	return 0
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSTEAM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getSteam(source)
	local identifiers = GetPlayerIdentifiers(source)
	for k,v in ipairs(identifiers) do
		if string.sub(v,1,5) == "steam" then
			return v
		end
	end
end
