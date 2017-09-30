#Include gbfscriptConfigUtilities.ahk

global flag := true
global pageURL := "http://game.granbluefantasy.jp/#event/teamraid033/gacha/index"
running := false
count := 0
maxCount := 9999

XButton2::
GoToPage(pageURL)
running := false
Return

XButton1::
if running
{
	running := false
	return
}

running := true
Loop
{	
	RandomClickWide(369, 421, clickVariance)
	Sleep, 2000
	Send {Space} 
	Sleep, 1000
	Send {Space}
	Sleep, 1000
	
	count := count + 1
	if (count >= maxCount)
	{
		count := 0
		break
	}
	if not running
	{
		count := 0
		break
	}
}
running := false
Return

z::
if running
{
	running := false
	return
}

running := true
Loop
{	
	RandomClick(369, 505, clickVarianceSmall)
	Sleep, 2000
	Send {Space} 
	Sleep, 1000
	Send {Space}
	Sleep, 10000
	
	count := count + 1
	if (count >= maxCount)
	{
		count := 0
		break
	}
	if not running
	{
		count := 0
		break
	}
}
running := false
Return
  
Esc:: 
ExitApp