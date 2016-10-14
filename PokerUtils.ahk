#Include gbfscriptConfigUtilities.ahk

global count := 0

SortArray(Array, Order="A") {
	;Order A: Ascending, D: Descending, R: Reverse
	MaxIndex := ObjMaxIndex(Array)
	If (Order = "R") {
		count := 0
		Loop, % MaxIndex 
			ObjInsert(Array, ObjRemove(Array, MaxIndex - count++))
		Return
	}
	Partitions := "|" ObjMinIndex(Array) "," MaxIndex
	Loop {
		comma := InStr(this_partition := SubStr(Partitions, InStr(Partitions, "|", False, 0)+1), ",")
		spos := pivot := SubStr(this_partition, 1, comma-1) , epos := SubStr(this_partition, comma+1)    
		if (Order = "A") {    
			Loop, % epos - spos {
				if (Array[pivot] > Array[A_Index+spos])
					ObjInsert(Array, pivot++, ObjRemove(Array, A_Index+spos))    
			}
		} else {
			Loop, % epos - spos {
				if (Array[pivot] < Array[A_Index+spos])
					ObjInsert(Array, pivot++, ObjRemove(Array, A_Index+spos))    
			}
		}
		Partitions := SubStr(Partitions, 1, InStr(Partitions, "|", False, 0)-1)
		if (pivot - spos) > 1	;if more than one elements
			Partitions .= "|" spos "," pivot-1		;the left partition
		if (epos - pivot) > 1	;if more than one elements
			Partitions .= "|" pivot+1 "," epos		;the right partition
	} Until !Partitions
}
 
Suit(card) {
	return SubStr(card, 3)
}

Val(card) {
	return SubStr(card, 1, 2)
}

; selects cards from space and returns a binary array
Select(cards, space, byref ret) {
	for i, card in cards {
		for j, card1 in space {
			If (card == card1) {
				ret[j] := 1
			}
		}
	}
}

PickCards(byref cards, byref ret) {
	oldcards := cards.clone()
	SortArray(cards)
	
	matchingCards := Object() ; potential cards to keep that are consecutive
	matchingCount := 0 ; if 2 or greater, the hand is a winning hand with pairs/etc
	
	suit0 := "" ; first encountered suit
	suit0Count := 0 ; number of cards matching suit0
	suit1 := "" ; second encountered suit
	suit1Count := 0 ; number of cards matching suit1
	prev := "" ; previous card
	consecutive := 0 ; number of cards in a row seen with the same value
	straight := 0 ; number of cards in a straight
	straightStart := 1 ; start of the straight
	joker := 0 ; is there a joker?
	usedJoker := 0 ; has the straight used the joker?
	For i, card in cards {
		If (i != 1) {
			If (Val(card) == Val(prev)) {
				consecutive++
				If (consecutive == 2) {
					matchingCards.Insert(prev)
					matchingCards.Insert(card)
					matchingCount += 1 ; if this happens twice, it's a 2 pair, a winning hand
				} Else If (consecutive > 2) {
					matchingCards.Insert(card)
					matchingCount := 2 ; there is a triple, so this is a winning hand
				}
			} Else {
				consecutive := 1

				If (prev == "00x") {
					; if prev is joker, ignore it (for now)
					straight := 1
					straightStart := i
				} Else If (Val(card) + 0 == Val(prev) + 1) {
					straight++
				} Else If (Val(card) + 0 == Val(prev) + 2 && joker && !usedJoker) {
					straight += 2
					usedJoker := true
				} Else If (i == 2 || (i == 3 && joker)) {
					; Only reset if straight < 4 or straight is 3 and there's a joker
					; because I want to save a 4-straight
					straight := 1
					straightStart := i
					usedJoker := 0
				}
			}
			
			If (suit0 == "") {
				suit0 := Suit(card)
			} Else If (Suit(card) == suit0) {
				suit0Count++
			} Else If (suit1 == "") {
				suit1 := Suit(card)
				suit1Count++
			} Else If (Suit(card) == suit1) {
				suit1Count++
			}
		} Else {
		
			If (card == "00x") {
				joker := 1
				matchingCards.Insert(card)
				matchingCount += 1 ; there's definitely a pair
				suit0Count := 1
				suit1Count := 1
			} Else {
				suit0 := Suit(card)
				suit0Count := 1
				consecutive := 1
				straight := 1
			}
		}
		
		prev := card
	}
	
	If(joker && !usedJoker) {
		straight++
	}
	
	ret := Object()
	Loop 5 {
		ret.Insert(0)
	}
	
	If (matchingCount > 1) {
		Select(matchingCards, oldcards, ret)
	} Else If (suit0Count == 5 || straight == 5) {
		; keep the whole hand
		curr := 1
		Loop, 5 {
			ret[curr] := 1
			curr++
		}
	} Else If (suit0Count == 4) {
		for i, card in oldcards {
			If (Suit(card) == suit0 || card == "00x") {
				ret[i] := 1
			}
		}
	} Else If (suit1Count == 4) {
		for i, card in oldcards {
			If (Suit(card) == suit1 || card == "00x") {
				ret[i] := 1
			}
		}
	} Else If (straight == 4) {
		curr := Val(cards[straightStart])+0
		Loop, %straight% {
			For i, card in oldcards {
				If (Val(card)+0 == curr) {
					ret[i] := 1
					Break
				}
			}
			curr++
		}
		
		If (joker) {
			For i, card in oldcards {
				If (card == "00x") {
					ret[i] := 1
					Break
				}
			}
		}
	} Else If (matchingCount == 1) {
		Select(matchingCards, oldcards, ret)
	}
}
