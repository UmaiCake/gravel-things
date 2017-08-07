;----------------------------------------------
;Global Config
;----------------------------------------------

;Configs
global roomJoinClicks := 5
global clickVariance := 20
global clickVarianceSmall := 6

global waitImageTimeoutMax := 10
global waitCoopHomeMax := 7
global waitResultMax := 3
global maxGlobalTimeout := 999

global maxAttackTurns := 10
global maxBattleNonActions := 2
global maxBattles := 999
global maxBattles := maxBattles * waitResultMax

;Coordinates
global coop_refresh_X := 120
global coop_refresh_Y := 575

global pending_first_X := 360
global pending_first_Y := 360

global vmate_icon_X := 605
global vmate_icon_Y := 70

global vmate_joinraid_X := 130
global vmate_joinraid_Y := 30

global vmate_refill_X := 120
global vmate_refill_Y := 140

global vmate_ok_X := 150
global vmate_ok_Y := 500

global last_hosted_X := 580
global last_hosted_Y := 760

global attack_button_X := 525
global attack_button_Y := 575

global join_confirm_X := 500
global join_confirm_Y := 820

global battle_end_X := 375
global battle_end_Y := 415

global first_summon_X := 180
global first_summon_Y := 570

global ready_button_X := 590
global ready_button_Y := 856

global select_party_button_X := 370
global select_party_button_Y := 1020

global select_summon_ok_X := 515
global select_summon_ok_Y := 900

global first_favorite_X := 368
global first_favorite_Y := 760

global vee_dialog_X := 324
global vee_dialog_Y := 584

global use_half_elixir_X := 500
global use_half_elixir_Y := 750

global use_item_ok_X := 373
global use_item_ok_Y := 745

global next_button_X := 608
global next_button_Y := 578

global wind_summon_X := 373
global wind_summon_Y := 402

global misc_summon_X := 604
global misc_summon_Y := 402

global dark_summon_X := 485
global dark_summon_Y := 402

global fav_summon_X := 625
global fav_summon_Y := 402

global auto_button_X := 128 
global auto_button_Y := 609

global go_button_X := 544
global go_button_Y := 592

global favorites_button_X := 130
global favorites_button_Y := 520

global stage_ok_X := 350
global stage_ok_Y1 := 680
global stage_ok_Y2 := 630

global story_X := 341
global story_2_Y := 600
global story_3_Y := 674
global story_4_Y := 750

global story_ok_X := 500
global story_ok_Y := 760

global story_skip_X := 200
global story_skip_Y := 920

global story_skip_ok_X := 490
global story_skip_ok_Y := 600

global battle_menu_X := 615
global battle_menu_Y := 110

global battle_retreat_X := 500
global battle_retreat_Y := 760

global battle_retreat_confirm_X := 500
global battle_retreat_confirm_Y := 520

;URL Strings
global ChromeBrowsers := "Chrome_WidgetWin_0,Chrome_WidgetWin_1"
global searchPoker := "#casino/game/poker"
global searchMypage := "#mypage"
global searchQuest := "#quest"
global searchQuestExtra := "#quest/extra"
global searchCoop := "#coopraid"
global searchCoopJoin := "#coopraid/offer"
global searchCoopRoom := "#coopraid/room"
global searchBattle := "#raid"
global searchStage := "stage"
global searchSelectSummon := "supporter"
global searchResults := "result"
global searchScene := "scene"
global searchGuildWars := "teamraid"
global searchPending := "unclaimed"

global coopHomeURL := "http://game.granbluefantasy.jp/#coopraid"
global coopJoinURL := "http://game.granbluefantasy.jp/#coopraid/offer"
global questURL := "http://game.granbluefantasy.jp/#quest"
global guildWarsURL := "http://game.granbluefantasy.jp/#event/teamraid031"
global repeatQuestURL := "http://game.granbluefantasy.jp/#event/teamraid031/supporter/719471/1"
global rabbitURL:= "http://game.granbluefantasy.jp/#quest/supporter/713431/0"
global pendingURL := "http://game.granbluefantasy.jp/#quest/assist/unclaimed"

global GBF_winHeight := 1080
global GBF_winWidth := 700
global coordinateMultiplier := 1



;----------Search Images------------;

global image_path := "image/"

global attack_button := "attack_button.png"
global attack_button_2 := "attack_button_2.png"

global wind_icon := "wind_icon.png"
global wind_icon_selected := "wind_icon_selected.png"
global misc_icon := "misc_icon.png"
global misc_icon_selected := "misc_icon_selected.png"
global fire_icon := "fire_icon.png"
global fire_icon_selected := "fire_icon_selected.png"
global dark_icon := "dark_icon.png"
global dark_icon_selected := "dark_icon_selected.png"
global fav_icon := "fav_icon.png"
global fav_icon_selected := "fav_icon_selected.png"

global use_skill := "use_skill.png"

global select_party_auto_select := "select_party_auto_select.png"
global select_party_auto_select_2 := "select_party_auto_select_2.png"

global special_members := "special_members.png"

global retreat_ok := "retreat_ok.png"

global select_support := "select_support.png"
global select_support_2 := "select_support_2.png"

global ready_start := "ready_to_start.png"
global ready_start_2 := "ready_to_start_2.png"

global wait_quest_start := "wait_quest_start.png"
global wait_quest_start_2 := "wait_quest_start_2.png"

global coopjoin_refresh := "coopjoin_refresh.png"
global coopjoin_refresh_2 := "coopjoin_refresh_2.png"

global coopjoin_room := "coopjoin_room.png"
global coopjoin_room_2 := "coopjoin_room_2.png"

global coopjoin_join_header := "coopjoin_join.png"
global coopjoin_join_header_2 := "coopjoin_join_2.png"

global last_hosted := "last_hosted.png"

global tap_start := "tap_start.png"

global special := "special.png"
global favorites_button := "favorites_button.png"

global featured_button := "featured_button.png"

global not_enough_ap := "not_enough_ap.png"
global not_enough_ap_2 := "not_enough_ap_2.png"

global not_enough_ap_gw := "not_enough_ap_gw.png"

global use_item := "use_item.png"
global use_item_2 := "use_item_2.png"

global use_item_gw := "use_item_gw.png"

global view_story := "view_story.png"

global story_summary := "story_summary.png"

global mole_icon := "mole.png"

global vmate_join := "vmate_join.png"

global vmate_refill := "vmate_refill.png"

global vmate_ok := "vmate_ok.png"

global ok_button := "ok_button.png"

;Time intervals
global default_button_delay := 500
global long_delay := 5000
global post_ready_button_delay := 3000
global post_attack_button_delay := 5000

global kill_time := 10000
global short_interval := 500
global default_interval := 1000
global medium_interval := 3000
global globalTimeoutMax := 1000

;Intialization
global globalTimeout := 0
global attackTurns := 1
global coopHomeCycles := 0
global resultScreenCycles := 0
global battleNonActions := 0
global battleCount := 0
SetKeyDelay, 100
CoordMode Pixel, Relative
CoordMode Mouse, Relative


;----------------------------------------------
;ImageSearch wrappers
;----------------------------------------------

ImageSearchWrapper(byref searchResultX, byref searchResultY, imageFileName)
{
	searchResultX := 0
	searchResultY := 0
	
	imagePath = %image_path%%imageFileName%
	ImageSearch, searchResultX, searchResultY, 0, 0, GBF_winWidth, GBF_winHeight, *20 %imagePath%
	
	if ErrorLevel = 2
	{
		updateLog("ImageSearch could not be completed")
		return false
	}
	else if ErrorLevel = 1
	{
		updateLog(imageFileName . " was not found.")
		return false
	}
	else 
	{
		updateLog(imageFileNAme . " found at: " . searchResultX . " , " . searchResultY)
		return true
	}
}

ImageSearchWrapperPoker(byref searchResultX, byref searchResultY, imageFileName, X1, Y1, X2, Y2)
{
	searchResultX := 0
	searchResultY := 0
	
	imagePath = %poker_image_path%%imageFileName%
	ImageSearch, searchResultX, searchResultY, X1, Y1, X2, Y2, *20 %imagePath%
	
	if ErrorLevel = 2
	{
		updateLog("ImageSearch could not be completed")
		return false
	}
	else if ErrorLevel = 1
	{
		;updateLog(imageFileName . " was not found.")
		return false
	}
	else 
	{
		updateLog(imageFileNAme . " found at: " . searchResultX . " , " . searchResultY)
		return true
	}
}

MultiImageSearch(byref searchResultX, byref searchResultY, imageFileArray)
{
	searchResultX := 0
	searchResultY := 0

	for index, imageFileName in imageFileArray
	{
		;updateLog("Searching " . imageFileName)
		if ImageSearchWrapper(singleSearchX, singleSearchY, imageFileName)
		{
			searchResultX := singleSearchX
			searchResultY := singleSearchY
			return imageFileName
		}
	}
	return "Not Found"
}

MultiImageSearchPoker(byref searchResultX, byref searchResultY, imageFileArray, X1, Y1, X2, Y2)
{
	searchResultX := 0
	searchResultY := 0

	for index, imageFileName in imageFileArray
	{
		;updateLog("Searching " . imageFileName)
		if ImageSearchWrapperPoker(singleSearchX, singleSearchY, imageFileName, X1, Y1, X2, Y2)
		{
			searchResultX := singleSearchX
			searchResultY := singleSearchY
			return imageFileName
		}
	}
	return "Not Found"
}


WaitForImage(byref searchResultX, byref searchResultY, imageFileName)
{
	searchResultX := 0
	searchResultY := 0
	waitImageTimeout := 0
		
	updateLog("Waiting for image: " . imageFileName)
	Loop
	{
		if waitImageTimeout >= maxWaitImageTimeout
		{
			updateLog("Image timeout reached.")
			waitImageTimeout := 0
			return false
		}
		if ImageSearchWrapper(instanceSearchX, instanceSearchY, imageFileName)
		{
			updateLog(imageFileName . " found.")
			
			searchResultX := instanceSearchX
			searchResultY := instanceSearchY
			return true
		}
		else
		{
			waitImageTimeout := waitImageTimeout + 1
		}
	}
	return false
}

MultiWaitForImage(byref searchResultX, byref searchResultY, imageFileArray)
{
	searchResultX := 0
	searchResultY := 0
	waitImageTimeout := 0
		
	updateLog("Waiting for image: " . imageFileName)
	Loop
	{
		if waitImageTimeout >= maxWaitImageTimeout
		{
			updateLog("Image timeout reached.")
			waitImageTimeout := 0
			return false
		}

		searchResult := MultiImageSearch(instanceSearchX, instanceSearchY, imageFileArray)
		
		for index, imageFileName in imageFileArray
		{
			if searchResult = %imageFileName%
			{
				updateLog(imageFileName . " found.")
				
				searchResultX := instanceSearchX
				searchResultY := instanceSearchY
				return imageFileName
			}
		}
		waitImageTimeout := waitImageTimeout + 1
	}
	return false
}

;----------------------------------------------
;Utilities
;----------------------------------------------

updateLog(LogString)
{
	global Logbox
	FormatTime, currentTime,, hh:mm:ss
	rownumber := LV_Add("", currentTime, LogString) 
	LV_Modify(rownumber, "Vis") 
}

ResizeWin(Width = 0,Height = 0)
{
  WinGetPos,X,Y,W,H,A
  Y := 0
  If %Width% = 0
	Width := W

  If %Height% = 0
	Height := H

  WinMove,A,,%X%,%Y%,%Width%,%Height%
}

GoToPage(pageURL)
{
	coopHomeCycles := 0
	resultScreenCycles := 0	
	battleNonActions := 0
		
	Sleep, default_interval
	Send, ^l 
	Sleep, 100
	Clipboard := pageURL
	Sleep, 100
	Send, ^v
	Sleep, 100
	Send, {ENTER}
	Sleep, default_interval
	Return
}

RandomClick(coordX, coordY, variance)
{
	Random, randX, 0 - variance, variance
	Random, randY, 0 - variance, variance
	
	;updateLog("Random coordinate modifiers: " . randX . ", " . randY)
	clickX := (coordX + randX) * coordinateMultiplier
	clickY := (coordY + randY) * coordinateMultiplier
	
	updateLog("Clicking coordinates: " . clickX . ", " . clickY)
	MouseMove clickX, clickY
	Click
}

RandomClickWide(coordX, coordY, variance)
{
	Random, randX, 0 - (variance*2), (variance*2)
	Random, randY, 0 - variance, variance
	
	;updateLog("Random coordinate modifiers: " . randX . ", " . randY)	
	clickX := (coordX + randX) * coordinateMultiplier
	clickY := (coordY + randY) * coordinateMultiplier
	
	updateLog("Clicking coordinates: " . clickX . ", " . clickY)
	MouseMove clickX, clickY
	Click
}

ClickSkill(character, skillNum)
{
	offset1 := (character - 1) * skillCharOffset
	offset2 := (skillNum - 1) * skillXOffset
	
	skillCoordX := skillX + offset1 + offset2
	
	updateLog("Clicking skill: " . character . "," . skillNum . " at " . skillCoordX . "," . skillY)
	
	RandomClick(skillCoordX, skillY, clickVarianceSmall)
	Sleep, % default_button_delay
}

FindElementInArray(ByRef foundIndex, inputArray, findThis)
{
	for index, element in inputArray
	{
		if InStr(element, findThis)
		{
			foundIndex := index
			return foundIndex
		}
	}
	return null
}

ArrayContains(searchIn, searchFor) {
	if !(IsObject(searchIn)) || (searchIn.Length() = 0)
		return 0
	for index, value in searchIn
		if (value = searchFor)
			return 1
	return 0
}

;----------------------------------------------
;Browser URL Tools
;----------------------------------------------

GetActiveChromeURL(){
	global ChromeBrowsers
	WinGetClass, sClass, A
	If sClass In % ChromeBrowsers
		Return GetBrowserURL_ACC(sClass)
	Else
		Return ""
}
 
GetActiveBrowserURL() {
	global ModernBrowsers, LegacyBrowsers
	WinGetClass, sClass, A
	If sClass In % ModernBrowsers
		Return GetBrowserURL_ACC(sClass)
	Else If sClass In % LegacyBrowsers
		Return GetBrowserURL_DDE(sClass) ; empty string if DDE not supported (or not a browser)
	Else
		Return ""
}
 
; "GetBrowserURL_DDE" adapted from DDE code by Sean, (AHK_L version by maraskan_user)
; Found at http://autohotkey.com/board/topic/17633-/?p=434518
 
GetBrowserURL_DDE(sClass) {
	WinGet, sServer, ProcessName, % "ahk_class " sClass
	StringTrimRight, sServer, sServer, 4
	iCodePage := A_IsUnicode ? 0x04B0 : 0x03EC ; 0x04B0 = CP_WINUNICODE, 0x03EC = CP_WINANSI
	DllCall("DdeInitialize", "UPtrP", idInst, "Uint", 0, "Uint", 0, "Uint", 0)
	hServer := DllCall("DdeCreateStringHandle", "UPtr", idInst, "Str", sServer, "int", iCodePage)
	hTopic := DllCall("DdeCreateStringHandle", "UPtr", idInst, "Str", "WWW_GetWindowInfo", "int", iCodePage)
	hItem := DllCall("DdeCreateStringHandle", "UPtr", idInst, "Str", "0xFFFFFFFF", "int", iCodePage)
	hConv := DllCall("DdeConnect", "UPtr", idInst, "UPtr", hServer, "UPtr", hTopic, "Uint", 0)
	hData := DllCall("DdeClientTransaction", "Uint", 0, "Uint", 0, "UPtr", hConv, "UPtr", hItem, "UInt", 1, "Uint", 0x20B0, "Uint", 10000, "UPtrP", nResult) ; 0x20B0 = XTYP_REQUEST, 10000 = 10s timeout
	sData := DllCall("DdeAccessData", "Uint", hData, "Uint", 0, "Str")
	DllCall("DdeFreeStringHandle", "UPtr", idInst, "UPtr", hServer)
	DllCall("DdeFreeStringHandle", "UPtr", idInst, "UPtr", hTopic)
	DllCall("DdeFreeStringHandle", "UPtr", idInst, "UPtr", hItem)
	DllCall("DdeUnaccessData", "UPtr", hData)
	DllCall("DdeFreeDataHandle", "UPtr", hData)
	DllCall("DdeDisconnect", "UPtr", hConv)
	DllCall("DdeUninitialize", "UPtr", idInst)
	csvWindowInfo := StrGet(&sData, "CP0")
	StringSplit, sWindowInfo, csvWindowInfo, `" ;"; comment to avoid a syntax highlighting issue in autohotkey.com/boards
	Return sWindowInfo2
}
 
GetBrowserURL_ACC(sClass) {
	global nWindow, accAddressBar
	If (nWindow != WinExist("ahk_class " sClass)) ; reuses accAddressBar if it's the same window
	{
		nWindow := WinExist("ahk_class " sClass)
		accAddressBar := GetAddressBar(Acc_ObjectFromWindow(nWindow))
	}
	Try sURL := accAddressBar.accValue(0)
	If (sURL == "") {
		WinGet, nWindows, List, % "ahk_class " sClass ; In case of a nested browser window as in the old CoolNovo (TO DO: check if still needed)
		If (nWindows > 1) {
			accAddressBar := GetAddressBar(Acc_ObjectFromWindow(nWindows2))
			Try sURL := accAddressBar.accValue(0)
		}
	}
	If ((sURL != "") and (SubStr(sURL, 1, 4) != "http")) ; Modern browsers omit "http://"
		sURL := "http://" sURL
	If (sURL == "")
		nWindow := -1 ; Don't remember the window if there is no URL
	Return sURL
}
 
; "GetAddressBar" based in code by uname
; Found at http://autohotkey.com/board/topic/103178-/?p=637687
 
GetAddressBar(accObj) {
	Try If ((accObj.accRole(0) == 42) and IsURL(accObj.accValue(0)))
		Return accObj
	Try If ((accObj.accRole(0) == 42) and IsURL("http://" accObj.accValue(0))) ; Modern browsers omit "http://"
		Return accObj
	For nChild, accChild in Acc_Children(accObj)
		If IsObject(accAddressBar := GetAddressBar(accChild))
			Return accAddressBar
}
 
IsURL(sURL) {
	Return RegExMatch(sURL, "^(?<Protocol>https?|ftp)://(?<Domain>(?:[\w-]+\.)+\w\w+)(?::(?<Port>\d+))?/?(?<Path>(?:[^:/?# ]*/?)+)(?:\?(?<Query>[^#]+)?)?(?:\#(?<Hash>.+)?)?$")
}
 
; The code below is part of the Acc.ahk Standard Library by Sean (updated by jethrow)
; Found at http://autohotkey.com/board/topic/77303-/?p=491516
 
Acc_Init()
{
	static h
	If Not h
		h:=DllCall("LoadLibrary","Str","oleacc","Ptr")
}
Acc_ObjectFromWindow(hWnd, idObject = 0)
{
	Acc_Init()
	If DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd, "UInt", idObject&=0xFFFFFFFF, "Ptr", -VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
	Return ComObjEnwrap(9,pacc,1)
}
Acc_Query(Acc) {
	Try Return ComObj(9, ComObjQuery(Acc,"{618736e0-3c3d-11cf-810c-00aa00389b71}"), 1)
}
Acc_Children(Acc) {
	If ComObjType(Acc,"Name") != "IAccessible"
		ErrorLevel := "Invalid IAccessible Object"
	Else {
		Acc_Init(), cChildren:=Acc.accChildCount, Children:=[]
		If DllCall("oleacc\AccessibleChildren", "Ptr",ComObjValue(Acc), "Int",0, "Int",cChildren, "Ptr",VarSetCapacity(varChildren,cChildren*(8+2*A_PtrSize),0)*0+&varChildren, "Int*",cChildren)=0 {
			Loop %cChildren%
				i:=(A_Index-1)*(A_PtrSize*2+8)+8, child:=NumGet(varChildren,i), Children.Insert(NumGet(varChildren,i-8)=9?Acc_Query(child):child), NumGet(varChildren,i-8)=9?ObjRelease(child):
			Return Children.MaxIndex()?Children:
		} Else
			ErrorLevel := "AccessibleChildren DllCall Failed"
	}
}