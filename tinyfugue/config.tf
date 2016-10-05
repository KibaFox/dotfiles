; TinyFugue Configuration
; =======================

; Highlighting
; ------------

; Pages
/def -p2 -aCcyan -P1B -t"^([\w']+) pages,?" hl_page1
/def -p2 -aCcyan -P1B -t"^In (?:a )?page-pose to you,? ([\w']+)" hl_page2
/def -p2 -aCcyan -mregexp -t'^You page,?' hl_page3
/def -p2 -aCcyan -mregexp -t'^You page-pose,?' hl_page4

; Whispers
/def -p2 -aCblue -P1B     -t"^([\w']+) whispers,?" hl_whisper1
/def -p3 -aCblue -mregexp -t'^You whisper,?' hl_whisper2

; Looks, smells, etc
/def -p5 -aCmagenta -P1B -t"([\w']+) (?:just )?looked at you" hl_look1
/def -p5 -aCmagenta -P1B -t"([\w']+) (?:just )?smell(?:s|ed) you" hl_smell1

; OOC
/def -p14 -P0Cyellow -t'(?:<OOC>|\(OOC\))' hl_ooc1
/def -p14 -P0Cyellow -t'^OOC:' hl_ooc2

; Events (arriving, system messages, etc)
/def -p15 -aCgray -mregexp -t'^>> ' hl_events1
/def -p15 -aCgray -mregexp -t'^## ' hl_events2

; Local Configuration
; -------------------
/load ~/.config/tinyfugue/config_local.tf