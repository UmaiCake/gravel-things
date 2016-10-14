#Include gbfscriptConfigUtilities.ahk

SetTimer, ForceExitApp, 8000000 ; 1h20 minutes

global maxAttackTurns := 999
global maxBattleNonActions := 2

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

	if InStr(sURL, searchStage)
	{
		updateLog("-----In Stage-----")
		RandomClick(go_button_X, go_button_Y, clickVariance)
		Sleep, % default_interval 
		continue
	}
	else if InStr(sURL, searchScene)
	{
		updateLog("-----In Story Scene -----")

		updateLog("Clicking Skip button")
		RandomClick(story_skip_X, story_skip_Y, clickVariance)
		Sleep, % default_interval
		
		updateLog("Clicking Skip OK button")
		RandomClick(story_skip_ok_X, story_skip_ok_Y, clickVariance)
		Sleep, % default_interval
		
		continue
	}
	if InStr(sURL, searchBattle)
	{
		updateLog("-----In Battle-----")
		
		battleActions := [mole_icon]
		searchResult := multiImageSearch(coordX, coordY, battleActions)

		if InStr(searchResult, mole_icon)
		{
			updateLog("Mole found, clicking on battle menu")
			RandomClick(battle_menu_X, battle_menu_Y, clickVariance)
			Sleep, % default_interval
			
			updateLog("Clicking on retreat")
			RandomClick(battle_retreat_X, battle_retreat_Y, clickVariance)
			Sleep, % default_interval
			
			updateLog("Clicking on retreat confirm")
			RandomClick(battle_retreat_confirm_X, battle_retreat_confirm_Y, clickVariance)
			Sleep, % medium_interval

			updateLog("Return to summon select")
			GoToPage(rabbitURL)
		}
		continue
	}
	else if InStr(sURL, searchResults)
	{
		updateLog("-----In Results Screen-----")
		attackTurns := 0
		globalTimeout := 0
		battleNonActions := 0
		
		resultScreenCycles := resultScreenCycles + 1
		
		updateLog("Results Screen cycles: " . resultScreenCycles)		
		if(resultScreenCycles >= waitResultMax)
		{
			resultsScreenCycles := 0
			updateLog("Going to Quests page")
			GoToPage(questURL)
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
	
	}
	else if InStr(sURL, searchCoop)
	{
		updateLog("-----In Coop Home-----")
	}
	else if InStr(sURL, searchSelectSummon)
	{
		updateLog("-----In Select Summon-----")
		
		selectSummonAutoSelect := [select_party_auto_select, select_party_auto_select_2, misc_icon, misc_icon_selected]
		searchResult := multiImageSearch(coordX, coordY, selectSummonAutoSelect)
		
		if InStr(searchResult, select_party_auto_select)
		{
			updateLog("Party Confirm detected, clicking OK button")
			
			RandomClick(coordX + 197, coordY + 201, clickVariance) 
			continue
		}
		else if InStr(searchResult, misc_icon)
		{
			updateLog("Clicking on summon icon")
			RandomClick(misc_summon_X, misc_summon_Y, clickVariance)
		}
		else if InStr(searchResult, misc_icon_selected)
		{
			updateLog("Clicking on first summon")
			RandomClick(first_summon_X, first_summon_Y, clickVariance) 
		}
		continue
	}
	else if InStr(sURL, searchQuest)
	{
		updateLog("-----In Quests Screen-----")
		GoToPage(rabbitURL)
	}	
	else if InStr(sURL, mypage)
	{
		updateLog("-----In Home Page-----")
		updateLog("Going to Quest page")
		GoToPage(rabbitURL)
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

