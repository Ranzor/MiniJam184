extends Control


func _ready() -> void:
	toggle_rage_meter(0)
	

func toggle_rage_meter(rage : int) -> void:
	if rage == 0:
		%Rage_0.visible = true
		%Rage_1.visible = false
		%Rage_2.visible = false
		%Rage_3.visible = false
	elif rage == 1:
		%Rage_0.visible = false
		%Rage_1.visible = true
		%Rage_2.visible = false
		%Rage_3.visible = false
	elif rage == 2:
		%Rage_0.visible = false
		%Rage_1.visible = false
		%Rage_2.visible = true
		%Rage_3.visible = false
	elif rage == 3:
		%Rage_0.visible = false
		%Rage_1.visible = false
		%Rage_2.visible = false
		%Rage_3.visible = true

func update_counter(counter : int) -> void:
	%Counter.text = str(counter)
