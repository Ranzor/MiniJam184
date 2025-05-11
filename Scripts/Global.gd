extends Node

var combo : int = 0:
	set(value):
		if value <= 0:
			value = 0
		combo = value
		COMBO_TEXT.update_combo_text(combo)

var HP_BAR : Control
var MAX_HP : int = 20
var HP : int = MAX_HP:
	set(value):
		HP = value
		if HP_BAR:
			HP_BAR.update_hp_bar(HP, MAX_HP - HP)
var COMBO_TEXT : Control
var RAGEMETER : Control
var PLAYER : Node2D
var BEATBOX : CharacterBody2D
var KNOCKBACK = 700
