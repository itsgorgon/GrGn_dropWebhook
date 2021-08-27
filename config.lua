--[[
#######################################################################
###			WEBHOOK PLAYER DROPPED SIMPLES PARA CREATIVE. 
###  ~~~~ !!! SCRIPT TOTALMENTE GRATUITO, PROIBIDO REVENDA !!! ~~~~
###				CRIADO POR: function Gorgon()#6534
### 		  (presto suporte apenas para creative)
#######################################################################
]]

gxrgxn = {}

gxrgxn["base"] = "creative" -- disponíveis apenas: creative / zirix

-- SE FOR ZIRIX MUDE PARA OS QUERY QUE VOCÊ USA, IGNORE SE ESTIVER USANDO CREATIVE:
gxrgxn["queryhomes"] = "homes/get_homeuserid" -- PADRÃO ZIRIX (CONFIRA SEU PREPARE SE TA IGUAL)
gxrgxn["querygarages"] = "losanjos/get_vehicle" -- PADRÃO ZIRIX (CONFIRA SEU PREPARE SE TA IGUAL)

gxrgxn["paypal"] = false -- Caso queira ativar o paypal, defina true. É obrigatório retornar a função abaixo, caso ative aqui.

gxrgxn["funcpaypal"] = nil -- Aqui puxe a função que retorna o valor do paypal.

gxrgxn["webhook"] = "https://discord.com/api/webhooks/880567146319581204/U-DQS6PSQVGCEHUc7uv2-dOD0jywm5T44tEIIaHso2EyNbPfEJ289NtIv44Hm07-1MQd" -- Link do webhook

gxrgxn["username"] = "Webhook info-pessoal by: GorGon" -- Nome do perfil do webhook

gxrgxn["avatarurl"] = "https://cdn.discordapp.com/attachments/477654326337208331/873606828855033916/LOGO_Arizona_RP_2000x2000.png" -- Imagem do perfil do webhook

gxrgxn["imgurl"] = "https://media3.giphy.com/media/BPe1fWG9uDoQ0/giphy.gif?cid=ecf05e47qdyxu6zzse18x2ncuksfkfoy7ymlv7rrimb1bbd6&rid=giphy.gif&ct=g" -- Imagem de canto (gif de jesus)

gxrgxn["armamentos"] = false -- Para habilitar/desabilitar informações das armas

gxrgxn["corembed"] = 12745742 -- Cor da lateral da embed do webhook. (Códigos:https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812)

-- PREENCHA TODAS AS INFORMAÇÕES ACIMA PARA O FUNCIONAMENTO DO SCRIPT.
-- CASO SEU SALVAMENTO DAS ARMAS NA DATABASE SEJA DIFERENTE, SERÁ NECESSÁRIO ALTERA-LO PARA FUNCIONAMENTO DESTAS INFORMAÇÕES.
-- PARA DESABILITAR AS INFORMAÇÕES DE ARMAS E MESMO ASSIM CONTINUAR USANDO, É SÓ DEFINIR "FALSE" EM "gxrgxn["armamentos"]" ACIMA.
-- PARA SUPORTE E/OU MELHORIAS, PODE ME CONTATAR QUE FECHAMOS O MENOR VALOR POSSÍVEL!
