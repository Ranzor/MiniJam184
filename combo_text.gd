extends Control

func _ready() -> void:
	Global.COMBO_TEXT = self

func update_combo_text(combo: int) -> void:
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

	%TheText.text = combo_text
	%Outline.text = combo_text
	scale += Vector2(combo*0.005, combo*0.005)
