extends Control

func _ready() -> void:
	Global.COMBO_TEXT = self

func update_combo_text(combo: int) -> void:
	if combo == 0:
		self.visible = false
		%TheText.text = ''
		%Outline.text = ''
		return
	else:
		self.visible = true

	var combo_text : String = 'x'

	combo_text += str(combo)

	%TheText.text = combo_text
	%Outline.text = combo_text
