#Include gbfscriptConfigUtilities.ahk

SetTimer, ForceExitApp, 3600000 ; 1h

global maxAttackTurns := 999
global maxBattleNonActions := 3
global maxGlobalTimeout := 8

Gui, Add, ListView, x6 y6 w400 h500 vLogbox LVS_REPORT, %A_Now%|Activity
 LV_ModifyCol(1, 60)
 GuiControl, -Hdr, Logbox
 Gui, Show, w410 h505, GBF Bot Log

;----------------------------------------------
;Main Loop
;----------------------------------------------

global globalTimeout := 0
global attackTurns := 0
global coopHomeCycles := 0
global resultScreenCycles := 0
global battleNonActions := 0

global waitResultMax := 3

CoordMode Pixel, Relative
CoordMode Mouse, Relative

Loop{
Sleep, % default_interval	
globalTimeout := globalTimeout + 1
updateLog("Timeout: " . globalTimeout)

;Seek browser URL
sURL := GetActiveChromeURL()
WinGetClass, sClass, A
If (sURL != "")
{
	;updateLog("The URL is : " . sURL)
	If (globalTimeout >= maxGlobalTimeout)
	{
		updateLog("Max Timeout Exceeded")
		Send, {F5}
		globalTimeout := 0
	}

	if InStr(sURL, searchBattle)
	{
		updateLog("-----In Battle-----")
		
		battleActions := [attack_button, attack_button_2]
		searchResult := multiImageSearch(coordX, coordY, battleActions)

		if InStr(searchResult, attack_button)
		{
				updateLog("Start Battle Sequence")
				
				Send 4w2q3w
				Sleep, % default_button_delay
				
				;RandomClickWide(attack_button_X, attack_button_Y, clickVariance)
				
				;Send, {F5}
				globalTimeout := 0
		}
		else
		{
			updateLog("Battle action not taken, battle non action count = " . battleNonActions)
			if (battleNonActions >= maxBattleNonActions)
			{
				updateLog("Battle non action count exceeded")
				battleNonActions := 0
				;RandomClick(next_button_X, next_button_Y, clickVariance)
			}
			else
			{
				battleNonActions := battleNonActions + 1
			}
		}
	}
	else if InStr(sURL, searchResults)
	{
		updateLog("-----In Results Screen-----")
		attackTurns := 0
		globalTimeout := 0
		resultScreenCycles := resultScreenCycles + 1
		
		updateLog("Results Screen cycles: " . resultScreenCycles)		
		if(resultScreenCycles >= waitResultMax)
		{
			resultsScreenCycles := 0
			updateLog("Going to Coop Home page")
			GoToPage(coopHomeURL)
			globalTimeout := 0
		}
		continue
	}
	
	else if InStr(sURL, searchCoopJoin)
	{
		updateLog("-----In Coop Join-----")
		
	}
	else if InStr(sURL, searchCoopRoom)
	{
		updateLog("-----In Coop Room-----")
		
		coopRoomActions := [wait_quest_start, wait_quest_start_2, ready_start, ready_start_2, select_support, select_support_2]
		searchResult := multiImageSearch(coordX, coordY, coopRoomActions)

		if InStr(searchResult, wait_quest_start)
		{
			updateLog("Waiting for quest to start, Ready status confirmed")
			globalTimeout := 0
		}
		else if InStr(searchResult, select_support)
		{
			updateLog("Clicking Select Party button")
			RandomClick(select_party_button_X, select_party_button_Y, clickVariance)
			globalTimeout := 0
		}
		else if InStr(searchResult, ready_start)
		{
			updateLog("Clicking Ready button")
			RandomClick(ready_button_X, ready_button_Y, clickVariance)
			;Sleep to prevent re-click
			Sleep, % post_ready_button_delay
			globalTimeout := 0
		}
		continue
	}
	else if InStr(sURL, searchCoop)
	{
		updateLog("-----In Coop Home-----")
		attackTurns := 0
		globalTimeout := 0
		
		coopHomeCycles := coopHomeCycles + 1
		updateLog("Coop Home cycles: " . coopHomeCycles)
		
		continue
	}
	else if InStr(sURL, searchSelectSummon)
	{
		updateLog("-----In Select Summon-----")
		
		selectSummonAutoSelect := [select_party_auto_select, select_party_auto_select_2, wind_icon, wind_icon_selected]
		searchResult := multiImageSearch(coordX, coordY, selectSummonAutoSelect)
		
		if InStr(searchResult, select_party_auto_select)
		{
			updateLog("Party Confirm detected, clicking OK button")
			
			RandomClick(coordX + 197, coordY + 201, clickVariance) 
			globalTimeout := 0
			continue
		}
		else if InStr(searchResult, wind_icon)
		{
			updateLog("Clicking on summon icon")
			RandomClick(wind_summon_X, wind_summon_Y, clickVariance)
			globalTimeout := 0
		}
		else if InStr(searchResult, wind_icon_selected)
		{
			updateLog("Clicking on first summon")
			RandomClick(first_summon_X, first_summon_Y, clickVariance) 		
			globalTimeout := 0			
		}
		continue
	}
	else if InStr(sURL, mypage)
	{
		updateLog("-----In Home Page-----")
		updateLog("Going to Coop Home page")
		GoToPage(coopHomeURL)
		continue
	}
	else
	{
		updateLog("URL not identified")
		continue
	}
}
Else
	updateLog("Chrome not detected (" . sClass . ")")


}

Return




;----------------------------------------------
;Keybinds
;----------------------------------------------

F1::
updateLog("Resizing window to " . GBF_winWidth . " x " . GBF_winHeight)
ResizeWin(GBF_winWidth, GBF_winHeight)
Return

F12::Pause

GuiClose:
ExitApp

Esc::
ExitApp

ForceExitApp:
SetTimer,  ForceExitApp, Off
ExitApp

