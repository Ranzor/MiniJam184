extends Control

var game_timer : float
var combo : Control
var combo_out : bool = false

func _ready() -> void:
	%ComboBar.max_value = 5*100
	%ComboBar.value = 0

func _physics_process(delta):
	if Global.combo > 0:
		game_timer += delta
		update_combo_bar()

func update_combo_bar() -> void:
	if not combo_out:
		%ComboBar.value = game_timer*100
		if game_timer > 5:
			combo_out = true
			%ComboBar.max_value = 1*100
	else:
		%ComboBar.value = game_timer*100
		if game_timer >= 1:
			game_timer = 0
			Global.combo -= 1


func reset_combo_bar_timer() -> void:
	game_timer = 0
	combo_out = false
	%ComboBar.max_value = 5*100
