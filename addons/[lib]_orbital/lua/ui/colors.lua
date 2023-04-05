local c = Color

ui.col = {
	OS 			    = c(155,0,255),
	Header 			= c(15,15,15,255),
	Gradient 		= c(85,85,85,200),
	Background 		= c(10,10,10,160),
	Outline 		= c(75,75,75,255),
	Hover 			= c(160,160,160,75),

	Button 			= c(130,130,130,150),
	ButtonHover 	= c(220,220,220,150),
	ButtonRed 		= c(240,0,0),
	ButtonGreen 	= c(0,240,0),
	ButtonBlack 	= c(25,25,25, 180),
	Close 			= c(235,235,235),
	CloseBackground = c(215, 0, 50),
	CloseHovered 	= c(235, 0, 70),

	TransGrey155 	= c(100,100,100,155),
	TransWhite50 	= c(255,255,255,50),
	TransWhite100 	= c(255,255,255,100),
	OffWhite 		= c(200,200,200),
	Grey 			= c(100,100,100),
	LightGrey		= c(150,150,150),
	FlatBlack 		= c(45,45,45),
	Black 			= c(0,0,0),
	White 			= c(255,255,255),
	Blue 			= c(0, 50, 200),
	Red 			= c(235,10,10),
	DarkRed			= c(200,10,10),
	Green 			= c(10,235,10),
	DarkGreen 		= c(0, 153, 51),
	Orange 			= c(245,120,0),
	Yellow 			= c(255,255,51),
	Gold 			= c(212,175,55),
	Purple 			= c(147,112,219),
	Pink 			= c(255,105,180),
	Brown 			= c(139,69,19)
}

if (CLIENT) then
	include 'theme.lua' -- lua refresh
end


function NeedReconnect()
	timer.Create('ReconnectNow', 1, 0, function()
		LocalPlayer():ChatPrint('Reconnect required!')
	--	LocalPlayer():ConCommand('connect darkrp.orbitalservers.gg')
	end)
end