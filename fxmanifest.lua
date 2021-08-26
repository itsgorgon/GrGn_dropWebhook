fx_version 'cerulean'
games { 'gta5' }

author 'function Gorgon()#6534'
description 'GrGn_dropWebhook' 
version '1.0'

client_scripts {
	"@vrp/lib/utils.lua",
	'config.lua',
}

server_scripts {
	"@vrp/lib/utils.lua",
	'server.lua',
	'config.lua',
}
