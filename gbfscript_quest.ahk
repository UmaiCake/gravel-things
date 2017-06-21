#Include gbfscriptConfigUtilities.ahk

SetTimer, ForceExitApp, 3600000 ; 1h20 minutes

global maxAttackTurns := 10
global maxBattleNonActions := 2
global maxBattles := 999

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
global battleCount := 0
global maxBattles := maxBattles * waitResultMax

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
		updateLog("Going to GW battle")
		GoToPage(repeatQuestURL)
	}
	if InStr(sURL, searchBattle)
	{
		updateLog("-----In Battle-----")
		
		battleActions := [attack_button, attack_button_2]
		searchResult := multiImageSearch(coordX, coordY, battleActions)

		if (InStr(searchResult, attack_button) or InStr(searchResult, attack_button_2))
		{
				updateLog("Start Battle Sequence")
				
				if(attackTurns >= 1)
				{
					updateLog("Not first turn")
					Send 1wer2qw3qe4q
					Sleep, % default_button_delay
					RandomClickWide(attack_button_X, attack_button_Y, clickVariance)			
					continue
				}
				
				updateLog("First turn detected")
				Send 1wer2q3qe4q

				Sleep, % long_delay
				RandomClickWide(attack_button_X, attack_button_Y, clickVariance)		
				attackTurns = attackTurns + 1
		}
		else
		{
			updateLog("Battle action not taken, battle non action count = " . battleNonActions)
			if (battleNonActions >= maxBattleNonActions)
			{
				updateLog("Battle non action count exceeded, clicking Next button")
				battleNonActions := 0

				;RandomClick(next_button_X, next_button_Y, clickVariance)
			}
			else
			{
				battleNonActions := battleNonActions + 1
			}
		}
		continue
	}
	else if InStr(sURL, searchResults)
	{
		updateLog("-----In Results Screen-----")
		attackTurns := 0
		globalTimeout := 0
		battleNonActions := 0
		
		battleCount := battleCount + 1
		updateLog("Battle count: " . battleCount)
		if(battleCount >= maxBattles)
		{
			MsgBox, 4,, Max battles reached - continue?
			IfMsgBox Yes
				battleCount := 0
			else
				ExitApp
		}
		
		resultScreenCycles := resultScreenCycles + 1
		
		updateLog("Results Screen cycles: " . resultScreenCycles)		
		if(resultScreenCycles >= waitResultMax)
		{
			resultsScreenCycles := 0
			updateLog("Going to GW battle")
			GoToPage(repeatQuestURL)
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
		
		selectSummonAutoSelect := [select_party_auto_select, select_party_auto_select_2, special_members, wind_icon, wind_icon_selected]
		searchResult := multiImageSearch(coordX, coordY, selectSummonAutoSelect)
		
		if InStr(searchResult, select_party_auto_select)
		{
			updateLog("Party Confirm detected, clicking OK button")
			
			RandomClick(coordX + 197, coordY + 201, clickVariance) 
			continue
		}
		else if InStr(searchResult, special_members)
		{
			updateLog("Special Member dialog found, clicking OK button")
			RandomClick(select_summon_ok_X, select_summon_ok_Y, clickVariance)
		}
		else if InStr(searchResult, wind_icon)
		{
			updateLog("Clicking on summon icon")
			RandomClick(wind_summon_X, wind_summon_Y, clickVariance)
		}
		else if InStr(searchResult, wind_icon_selected)
		{
			updateLog("Please select a summon")
			RandomClick(first_summon_X, first_summon_Y+40, clickVariance) 
		}
		continue
	}
	else if InStr(sURL, searchQuest)
	{
		updateLog("-----In Quests Screen-----")
		updateLog("Going to quest")
		GoToPage(repeatQuestURL)
	}	
	else if InStr(sURL, searchMypage)
	{
		updateLog("-----In Home Page-----")
		updateLog("Going to GW battle")
		GoToPage(repeatQuestURL)	
		continue
	}
	else if InStr(sURL, guildWarsURL)
	{
		updateLog("-----In GW Page-----")
		updateLog("Going to GW battle")
		GoToPage(repeatQuestURL)		
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

