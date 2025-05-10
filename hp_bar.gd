extends Control


func _ready() -> void:

	Global.HP_BAR = self

	init_hp_bar(Global.MAX_HP)

func init_hp_bar(max_hp: int) -> void:
	print(max_hp)
	%TheBar.max_value = max_hp
	$TheBar.value = max_hp

func update_hp_bar(hp: int) -> void:
	$TheBar.value = hp
