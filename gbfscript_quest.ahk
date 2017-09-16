#Include gbfscriptConfigUtilities.ahk

Gui, Add, ListView, x6 y6 w400 h500 vLogbox LVS_REPORT, %A_Now%|Activity
 LV_ModifyCol(1, 60)
 GuiControl, -Hdr, Logbox
 Gui, Show, w410 h505, GBF Bot Log

;----------------------------------------------
;Configs
;----------------------------------------------

global minutesTilKill := 120
global waitResultMax := 5
repeatQuestURL := "http://game.granbluefantasy.jp/#quest/supporter/721101/1/0/10234"
eventURL := "http://game.granbluefantasy.jp/#event/treasureraid059"

;----------------------------------------------
;Battle Sequence
;----------------------------------------------
BattleSequence1(attackTurns)
{
	SpecialTurns1 := [2]
	
	if(attackTurns <=1)
	{
		updateLog("1st turn action")

		Send 1rq2eq3r1we3qw4qe
		
		Sleep, % long_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)		
	}
	
	else if(ArrayContains(SpecialTurns1, attackTurns))
	{
		updateLog("Special group 1 action")		

		Send 2w

		Sleep, % default_button_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)	
	}	
	
	else
	{
		updateLog("Non-special turn action")

		Sleep, % default_button_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)	
	}

}

BattleSequence2(attackTurns)
{	
	if(attackTurns <=1)
	{
		updateLog("1st turn action")
		
		Send 1rqwe2qw4wq3eq
		
		Sleep, % long_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)	
	}
	
	else
	{
		updateLog("Non-special turn action")

		Sleep, % default_button_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)	
	}
}

BattleSequence3(attackTurns)
{
	SpecialTurns1 := [2]
	SpecialTurns2 := [3]
	SpecialTurns3 := [4]
	SpecialTurns4 := [5]
	SpecialTurns5 := [6]
	

	if(attackTurns <=1)
	{
		updateLog("1st turn action")
		
		Send 1q2q1e2q4e2q1w4w3q1r
		
		Sleep, % long_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)		
	}
	
	else if(ArrayContains(SpecialTurns1, attackTurns))
	{
		updateLog("2nd turn action")		

		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)			
	}
	
	else if(ArrayContains(SpecialTurns2, attackTurns))
	{
		updateLog("3rd turn action")		

		Send 3w

		Sleep, % default_button_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)			
	}
	
	else if(ArrayContains(SpecialTurns3, attackTurns))
	{
		updateLog("4th turn action")	
		
		Send 2e4q

		Sleep, % default_button_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)			
	}
	
	else if(ArrayContains(SpecialTurns4, attackTurns))
	{
		updateLog("5th turn action")		
		
		Send 3e

		Sleep, % default_button_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)			
	}
	
	else
	{
		updateLog("Non-special turn action")

		Send 1qwer3q3w
		
		Sleep, % default_button_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)	
	}

}

BattleSequence4(attackTurns)
{
	SpecialTurns1 := [2]
	SpecialTurns2 := [3]
	SpecialTurns3 := [4]
	SpecialTurns4 := [5]
	

	if(attackTurns <=1)
	{
		updateLog("1st turn action")
		
		Send 1q2q1w2q4w2q3q1r
		
		Sleep, % long_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)		
	}
	
	else if(ArrayContains(SpecialTurns1, attackTurns))
	{
		updateLog("2nd turn action")		

		Send 3w4e1e

		Sleep, % default_button_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)			
	}
	
	else if(ArrayContains(SpecialTurns2, attackTurns))
	{
		updateLog("3rd turn action")	
		
		Send 2e

		Sleep, % default_button_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)			
	}
	
	else if(ArrayContains(SpecialTurns3, attackTurns))
	{
		updateLog("4th turn action")		
		
		Send 3e4q

		Sleep, % default_button_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)			
	}
	
	else
	{
		updateLog("Non-special turn action")

		Send 1qwer3q3w
		
		Sleep, % default_button_delay
		RandomClickWide(attack_button_X, attack_button_Y, clickVariance)	
	}

}
BattleSequence5(attackTurns)
{
	Send 1rq3r1we3qw4qe
	RandomClickWide(attack_button_X, attack_button_Y, clickVariance)
}

;----------------------------------------------
;Main Loop
;----------------------------------------------
global maxBattles := maxBattles * waitResultMax
killTime := 60000 * minutesTilKill
SetTimer, ForceExitApp, %killTime%

Loop{
Sleep, % default_interval	
globalTimeout := globalTimeout + 1
updateLog("Timeout: " . globalTimeout)

;Seek browser URL
sURL := GetActiveChromeURL()
WinGetClass, sClass, A
If (sURL != "")
{	
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
			
			battleSequence1(attackTurns)
			
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
			Sleep, % default_interval
			
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
		updateLog("Going to event page")
		GoToPage(eventURL)	
		continue
	}
	else if InStr(sURL, guildWarsURL)
	{
		updateLog("-----In GW Page-----")
		updateLog("Going to quest summon select")
		GoToPage(repeatQuestURL)		
	}
	else if InStr(sURL, eventURL)
	{
		updateLog("-----In Event Page-----")
		
		;SelectQuest()		
		
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

SelectQuest()
{
		Sleep, 2000
		Send  {WheelDown}
		Send  {WheelDown}
		
		Sleep, 1000
		
		RandomClick(364,1000, clickVarianceSmall)
		
		Sleep, 1000
		
		RandomClick(498, 877, clickVarianceSmall)
		
		Sleep, 5000
}


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

