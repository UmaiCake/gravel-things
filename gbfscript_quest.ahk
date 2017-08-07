#Include gbfscriptConfigUtilities.ahk

SetTimer, ForceExitApp, 10000000 

Gui, Add, ListView, x6 y6 w400 h500 vLogbox LVS_REPORT, %A_Now%|Activity
 LV_ModifyCol(1, 60)
 GuiControl, -Hdr, Logbox
 Gui, Show, w410 h505, GBF Bot Log

;----------------------------------------------
;Main Loop
;----------------------------------------------
global maxBattles := maxBattles * waitResultMax


global repeatQuestURL := "http://game.granbluefantasy.jp/#quest/supporter/719601/1/0/10226"
SpecialTurns1 := [2]
SpecialTurns2 := [3]
;SpecialTurns1 := [2]
;SpecialTurns2 := [3]
;SpecialTurns3 := [4]
;SpecialTurns4 := [5]

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
		updateLog("Going to quest summon select")
		GoToPage(repeatQuestURL)
	}
	if InStr(sURL, searchBattle)
	{
		updateLog("-----In Battle-----")
		updateLog("Turn count: " . attackTurns)
		
		battleActions := [attack_button, attack_button_2]
		searchResult := multiImageSearch(coordX, coordY, battleActions)		

		if (InStr(searchResult, attack_button) or InStr(searchResult, attack_button_2))
		{
			updateLog("-----Start Battle Sequence-----")	
			
			if(attackTurns <=1)
			{
				updateLog("1st turn action")
				
				Send 1rwe
				
				Sleep, % long_delay
				RandomClickWide(attack_button_X, attack_button_Y, clickVariance)		
			}
			
			else if(ArrayContains(SpecialTurns1, attackTurns))
			{
				updateLog("Special group 1 action")		

				Send 2e3e

				Sleep, % default_button_delay
				RandomClickWide(attack_button_X, attack_button_Y, clickVariance)			
			}
			
			else if(ArrayContains(SpecialTurns2, attackTurns))
			{
				updateLog("Special group 2 action")	
				
				Send 1q

				Sleep, % default_button_delay
				RandomClickWide(attack_button_X, attack_button_Y, clickVariance)			
			}
			
			else if(ArrayContains(SpecialTurns3, attackTurns))
			{
				updateLog("Special group 3 action")		

				Sleep, % default_button_delay
				RandomClickWide(attack_button_X, attack_button_Y, clickVariance)			
			}
			
			else if(ArrayContains(SpecialTurns4, attackTurns))
			{
				updateLog("Special group 4 action")	

				Sleep, % default_button_delay
				RandomClickWide(attack_button_X, attack_button_Y, clickVariance)			
			}

			else
			{
				updateLog("Non-special turn action")

				Sleep, % default_button_delay
				RandomClickWide(attack_button_X, attack_button_Y, clickVariance)	
			}
			attackTurns += 1 
			globalTimeout := 0
		}
		else
		{
			updateLog("Battle action not taken, battle non action count = " . battleNonActions)
			if (battleNonActions >= maxBattleNonActions)
			{
				;updateLog("Battle non action count exceeded, clicking Next button")
				battleNonActions := 0

				;RandomClick(next_button_X, next_button_Y, clickVariance)
			}
			else
			{
				battleNonActions += 1 
			}
		}
		continue
	}
	else if InStr(sURL, searchResults)
	{
		updateLog("-----In Results Screen-----")
		attackTurns := 1
		globalTimeout := 0
		battleNonActions := 0
		
		battleCount += 1
		updateLog("Battle count: " . battleCount)
		if(battleCount >= maxBattles)
		{
			MsgBox, 4,, Max battles reached - continue?
			IfMsgBox Yes
				battleCount := 0
			else
				ExitApp
		}
		
		resultScreenCycles += 1
		
		updateLog("Results Screen cycles: " . resultScreenCycles)		
		if(resultScreenCycles >= waitResultMax)
		{
			resultsScreenCycles := 0
			updateLog("Going to quest summon select")
			GoToPage(repeatQuestURL)
		}
		continue
	}
	
	else if InStr(sURL, searchCoopJoin)
	{
		updateLog("-----In Coop Join-----")
		updateLog("Going to quest summon select")
		GoToPage(repeatQuestURL)
	}
	else if InStr(sURL, searchCoopRoom)
	{
		updateLog("-----In Coop Room-----")
		updateLog("Going to quest summon select")
		GoToPage(repeatQuestURL)
	}
	else if InStr(sURL, searchCoop)
	{
		updateLog("-----In Coop Home-----")
		updateLog("Going to quest summon select")
		GoToPage(repeatQuestURL)		
	}
	else if InStr(sURL, searchSelectSummon)
	{
		updateLog("-----In Select Summon-----")
		
		selectSummonAutoSelect := [select_party_auto_select, select_party_auto_select_2, special_members, fav_icon, fav_icon_selected]
		searchResult := multiImageSearch(coordX, coordY, selectSummonAutoSelect)
		
		if (InStr(searchResult, select_party_auto_select) or InStr(searchResult, select_party_auto_select_2))
		{
			updateLog("Party Confirm detected, clicking OK button")
			
			RandomClick(select_summon_ok_X, select_summon_ok_Y, clickVariance) 
			continue
		}
		else if InStr(searchResult, special_members)
		{
			updateLog("Special Member dialog found, clicking OK button")
			RandomClick(select_summon_ok_X, select_summon_ok_Y, clickVariance)
		}
		else if InStr(searchResult, fav_icon)
		{
			updateLog("Clicking on summon icon")
			RandomClick(fav_summon_X, fav_summon_Y, clickVariance)
		}
		else if InStr(searchResult, fav_icon_selected)
		{
			updateLog("Clicking first summon")
			RandomClick(first_summon_X, first_summon_Y+40, clickVariance) 
		}
		continue
	}
	else if InStr(sURL, searchQuest)
	{
		updateLog("-----In Quests Screen-----")
		updateLog("Going to quest summon select")
		GoToPage(repeatQuestURL)
	}	
	else if InStr(sURL, searchMypage)
	{
		updateLog("-----In Home Page-----")
		updateLog("Going to quest summon select")
		GoToPage(repeatQuestURL)	
		continue
	}
	else if InStr(sURL, guildWarsURL)
	{
		updateLog("-----In GW Page-----")
		updateLog("Going to quest summon select")
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
updateLog("Resizing favow to " . GBF_winWidth . " x " . GBF_winHeight)
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

