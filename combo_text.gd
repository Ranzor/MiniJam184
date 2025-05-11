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
		%TheText.text = ''
		%Outline.text = ''
		scale = Vector2(3, 3)
		return
	else:
		self.visible = true

	var combo_text : String = 'x'

	combo_text += str(combo)

	%Label1.text = combo_text
	%Label2.text = combo_text
	#scale += Vector2(combo*0.005, combo*0.005)

func set_labels(combo: int) -> void:
	if combo < 10:
		label1 = %TextOneSmall
		label2 = %TextTwoSmall
	elif combo < 25:
		label1 = %TextOneMedium
		label2 = %TextTwoMedium
	elif combo < 40:
		label1 = %TextOneLarge
		label2 = %TextTwoLarge
	elif combo > 49:
		label1 = %TextOneMega
		label2 = %TextTwoMega
	

