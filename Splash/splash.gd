extends MarginContainer
func _ready():
	var animation = $AnimationPlayer

func _on_animation_player_animation_finished(load_splash_screen):
	SceneTransition.transition_to_scene("res://UI/MainMenu/main_menu.tscn")
