extends Control


func _ready() -> void:

	Global.HP_BAR = self

	init_hp_bar(Global.MAX_HP)

func init_hp_bar(max_hp: int) -> void:
	%TheBar.max_value = max_hp
	%TheBar.value = max_hp
	%combat_text.text = str(0)

func update_hp_bar(hp: int, damage : int) -> void:
	%TheBar.value = hp
	%combat_text.text = str(damage)
