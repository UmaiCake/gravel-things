#Include gbfscriptConfigUtilities.ahk

SetTimer, ForceExitApp, 3600000 ; 1h20 minutes

global maxAttackTurns := 999
global maxBattleNonActions := 5

Gui, Add, ListView, x6 y6 w400 h500 vLogbox LVS_REPORT, %A_Now%|Activity
 LV_ModifyCol(1, 60)
 GuiControl, -Hdr, Logbox
 Gui, Show, w410 h505, GBF Bot Log
;----------------------------------------------
;Main Loop
;----------------------------------------------

global globalTimeout := 0
global attackTurns := 0
global resultScreenCycles := 0
global battleNonActions := 0
global scrollCount := 0

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

	if InStr(sURL, searchBattle)
	{
		updateLog("-----In Battle-----")
		
		battleActions := [attack_button, attack_button_2]
		searchResult := multiImageSearch(coordX, coordY, battleActions)

		if InStr(searchResult, attack_button)
		{
			if(attackTurns < maxAttackTurns)
			{
				updateLog("Battle sequence, battle turn count = " . attackTurns)
				Sleep % default_button_delay 
									
				ClickSkill(4,2)		
				ClickSkill(1,2)			
				ClickSkill(1,3)
				ClickSkill(1,4)
				ClickSkill(3,2)	
				
				Sleep % default_button_delay
				
				RandomClickWide(attack_button_X, attack_button_Y, clickVariance)
				Sleep, % post_attack_button_delay
				
				attackTurns := attackTurns + 1
			}
			else
			{
				updateLog("Max battle turns exceeded, no action taken")
			}
		}
		else
		{
			updateLog("Battle action not taken, battle non action count = " . battleNonActions)
			if (battleNonActions >= maxBattleNonActions)
			{
				updateLog("Battle non action count exceeded, clicking Vee dialog and Next button")
				battleNonActions := 0
				
				RandomClick(vee_dialog_X, vee_dialog_Y, clickVariance)
				Sleep, % default_button_delay
				RandomClick(next_button_X, next_button_Y, clickVariance)
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
		
		resultScreenCycles := resultScreenCycles + 1
		
		updateLog("Results Screen cycles: " . resultScreenCycles)		
		if(resultScreenCycles >= waitResultMax)
		{
			resultsScreenCycles := 0
			updateLog("Going to GW page")
			GoToPage(guildWarsURL)
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
		
		scrollCount = 0
		
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
	}	
	else if InStr(sURL, searchGuildWars)
	{
		updateLog("-----In Guild Wars Screen-----")
		Sleep, % default_interval
		
		GWActions := [battle_bosses, VH_Eye, use_item, not_enough_ap]
		searchResult := multiImageSearch(coordX, coordY, GWActions)
		if InStr(searchResult, battle_bosses)
		{
			updateLog("Battle Bosses icon detected, clicking")
			RandomClick(coordX, coordY+50, clickVariance)
		}
		else if InStr(searchResult, VH_Eye)
		{
			updateLog("Clicking VH Eye")
			RandomClick(coordX, coordY, clickVariance)		
		}
		else if InStr(searchResult, not_enough_ap)
		{
			updateLog("Not Enough AP dialog found, clicking Use button")
			RandomClick(coordX + 206, coordY + 490, clickVariance)
		}
		else if InStr(searchResult, use_item)
		{
			updateLog("Use Item dialog found, clicking OK button")
			RandomClick(use_item_ok_X, use_item_ok_Y, clickVariance)
		}
		else 
		{
			updateLog(scrollCount)
			if(scrollCount < 99)
			{
				updateLog("Nothing was found, scrolling down page")
				
				Send {WheelDown}
				Sleep, % default_delay
				
				scrollCount = %scrollCount% + 1
			}
			else
			{
				updateLog("Already scrolled down, no action taken")
			}
		}

		continue
	}
	else if InStr(sURL, mypage)
	{
		updateLog("-----In Home Page-----")
		updateLog("Going to GW page")
		GoToPage(GuildWarsURL)
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
