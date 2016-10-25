; TinyFugue Configuration
; =======================

; Highlighting
; ------------

; Pages
/def -p2 -abCcyan -P1B -t"^([^\s:;,.]+) pages,?" hl_page1
/def -p2 -abCcyan -P1B -t"^In (?:a )?page-pose to you,? ([^\s:;,.]+)" hl_page2
/def -p2 -aCcyan -mregexp -t'^You page,?' hl_page3
/def -p2 -aCcyan -mregexp -t'^You page-pose,?' hl_page4

; Whispers
/def -p2 -abCblue -P1B     -t"^([^\s:;,.]+) whispers,?" hl_whisper1
/def -p3 -aCblue -mregexp -t'^You whisper,?' hl_whisper2

; Looks, smells, etc
/def -p5 -abCmagenta -P1B -t"([^\s:;,.]+) (?:just )?looked at you" hl_look1
/def -p5 -abCmagenta -P1B -t"([^\s:;,.]+) (?:just )?smell(?:s|ed) you" hl_smell1

; OOC
/def -p14 -P0Cyellow -t'<OOC>|\(OOC\)' hl_ooc1
/def -p14 -P0Cyellow -t'^OOC:' hl_ooc2

; Events (arriving, system messages, etc)
/def -p15 -aCgray -mregexp -t'^>> ' hl_events1
/def -p15 -aCgray -mregexp -t'^##' hl_events2

; Teleport summons
/def -p16 -abCcyan -mregexp -t'would like you to teleport to them' hl_tp1

; Page Mail
/def -p16 -abCcyan -mregexp -t'[Yy]ou sense that you have new mail' hl_mail1

; Local Configuration
; -------------------
/load ~/.config/tinyfugue/config_local.tf
