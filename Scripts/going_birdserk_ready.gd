extends Control

func _ready() -> void:
	await $AnimationPlayer.animation_finished
	SceneTransition.transition_to_scene("res://level_1.tscn")
	Beatbox.reset()
