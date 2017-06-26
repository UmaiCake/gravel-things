#Include gbfscriptConfigUtilities.ahk

SetTimer, ForceExitApp, 5000000

Gui, Add, ListView, x6 y6 w400 h500 vLogbox LVS_REPORT, %A_Now%|Activity
 LV_ModifyCol(1, 60)
 GuiControl, -Hdr, Logbox
 Gui, Show, w410 h505, GBF Bot Log

;----------------------------------------------
;Main Loop
;----------------------------------------------
global maxAttackTurns := 4
global maxBattles := maxBattles * waitResultMax

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
		updateLog("Going to Pending page")
		GoToPage(pendingURL)
		globalTimeout := 0
	}
		
	else if InStr(sURL, searchStage)
	{
		updateLog("-----In Stage-----")
		updateLog("Going to Pending page")
		GoToPage(pendingURL)
		continue

	}
	else if InStr(sURL, searchBattle)
	{
		updateLog("-----In Battle-----")
		updateLog("Turn count: " . attackTurns)
		globalTimeout := 0
		
		battleActions := [attack_button, attack_button_2]
		searchResult := multiImageSearch(coordX, coordY, battleActions)
		
		if(attackTurns >= maxAttackTurns)
		{
			updateLog("Max attack turns reached")
			updateLog("Going to Pending page")
			GoToPage(pendingURL)
			attackTurns := 0
			continue
		}
		
		if (InStr(searchResult, attack_button) or InStr(searchResult, attack_button_2))
		{
			updateLog("-----Start Battle Sequence-----")	
			
			if(attackTurns <=1)
			{
				updateLog("1st turn action")
				
				Send 1wer2q3qe4q

				Sleep, % long_delay
				RandomClickWide(attack_button_X, attack_button_Y, clickVariance)		
			}
			
			else if(ArrayContains(SpecialTurns, attackTurns))
			{
				updateLog("Special turn action")

				Sleep, % default_button_delay
				RandomClickWide(attack_button_X, attack_button_Y, clickVariance)			
			}
			
			else
			{
				updateLog("Non-special turn action")
				
				Send 1r

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
			updateLog("Going to Pending page")
			GoToPage(pendingURL)
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
		
		selectSummonAutoSelect := [select_party_auto_select, select_party_auto_select_2, special_members, fav_icon, fav_icon_selected]
		searchResult := multiImageSearch(coordX, coordY, selectSummonAutoSelect)
		
		if (InStr(searchResult, select_party_auto_select) or InStr(searchResult, select_party_auto_select_2))
		{
			updateLog("Party Confirm detected, clicking OK button")
			RandomClick(coordX + 197, coordY + 201, clickVariance) 
			globalTimeout := 0
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
			RandomClick(fav_summon_X, fav_summon_Y+40, clickVariance)
			globalTimeout := 0
		}
		else if InStr(searchResult, fav_icon_selected)
		{
			updateLog("Clicking on first summon")
			RandomClick(first_summon_X, first_summon_Y+40, clickVariance) 
			globalTimeout := 0
		}
		continue
	}
	else if InStr(sURL, searchPending)
	{
		updateLog("-----In Pending Screen-----")					

		;Send  {Space}
		Sleep, % default_interval		
		
		pendingActions := [vmate_join, vmate_refill, vmate_ok, ok_button]
		searchResult := multiImageSearch(coordX, coordY, pendingActions)
		
		if InStr(searchResult, vmate_join)
		{
			updateLog("VMate join raid button found, clicking")
			RandomClick(vmate_joinraid_X, vmate_joinraid_Y, clickVarianceSmall)
			Sleep, % default_interval
			globalTimeout := 0
		}
		else if InStr(searchResult, vmate_refill)
		{
			updateLog("VMate refill button found, clicking")
			RandomClick(vmate_refill_X, vmate_refill_Y, clickVarianceSmall)
			Sleep, % medium_interval
			globalTimeout := 0
		}
		else if InStr(searchResult, vmate_ok)
		{
			updateLog("VMate OK button found, raid was not joined")
			RandomClick(vmate_ok_X, vmate_ok_Y, clickVariance)
			Sleep, % default_interval
			
			updateLog("Clicking first pending")
			RandomClick(pending_first_X, pending_first_Y, clickVariance)	
			Sleep, % medium_interval
		}
		else if InStr(searchResult, ok_button)
		{
			updateLog("Dialog found, pressing space")
			Send {Space}
			Sleep, % default_interval
			
			updateLog("Clicking first pending")
			RandomClick(pending_first_X, pending_first_Y, clickVariance)	
			Sleep, % medium_interval
		}
		else
		{
			updateLog("Clicking VMate icon")
			RandomClick(vmate_icon_X, vmate_icon_Y, clickVarianceSmall)
		}
		
		continue
	}	
	else if InStr(sURL, searchQuest)
	{
		updateLog("-----In Quest Page-----")
		updateLog("Going to Pending page")
		GoToPage(pendingURL)
		continue	
	}
	else if InStr(sURL, mypage)
	{
		updateLog("-----In Home Page-----")
		updateLog("Going to Pending page")
		GoToPage(pendingURL)
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

