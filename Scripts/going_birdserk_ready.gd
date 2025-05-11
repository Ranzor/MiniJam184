extends Control

func _ready() -> void:
	AudioManager.play_sound(preload("res://Audio/seagull-2-89447.mp3"))
	await $AnimationPlayer.animation_finished
	SceneTransition.transition_to_scene("res://level_1.tscn")
	Beatbox.reset()
