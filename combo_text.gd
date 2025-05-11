extends Control

var label1 : Label
var label2 : Label

func _ready() -> void:
	Global.COMBO_TEXT = self

	label1 = %TextOneSmall
	label2 = %TextTwoSmall

func update_combo_text(combo: int) -> void:

	set_labels(combo)

	if combo == 0:
		self.visible = false
		label1.text = ''
		label2.text = ''
		scale = Vector2(3, 3)
		return
	else:
		self.visible = true

	var combo_text : String = 'x'

	combo_text += str(combo)

	label1.text = combo_text
	label2.text = combo_text
	#scale += Vector2(combo*0.005, combo*0.005)

func set_labels(combo: int) -> void:
	if combo == 0:
		%combo_text_small.visible = false
		%combo_text_medium.visible = false
		%combo_text_large.visible = false
		%combo_text_mega.visible = false
	if combo < 10:
		label1 = %TextOneSmall
		label2 = %TextTwoSmall
		%combo_text_small.visible = true
		%combo_text_medium.visible = false
		%combo_text_large.visible = false
		%combo_text_mega.visible = false
	elif combo < 25:
		label1 = %TextOneMedium
		label2 = %TextTwoMedium
		%combo_text_small.visible = false
		%combo_text_medium.visible = true
		%combo_text_large.visible = false
		%combo_text_mega.visible = false
	elif combo < 50:
		label1 = %TextOneLarge
		label2 = %TextTwoLarge
		%combo_text_small.visible = false
		%combo_text_medium.visible = false
		%combo_text_large.visible = true
		%combo_text_mega.visible = false
	else:
		label1 = %TextOneMega
		label2 = %TextTwoMega
		%combo_text_small.visible = false
		%combo_text_medium.visible = false
		%combo_text_large.visible = false
		%combo_text_mega.visible = true
	
