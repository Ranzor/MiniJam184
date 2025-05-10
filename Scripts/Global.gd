extends Node

var combo : int = 0:
	set(value):
		combo = value
		COMBO_TEXT.update_combo_text(combo)




var HP_BAR : Control
var MAX_HP : int = 20
var COMBO_TEXT : Control