extends Node2D


func _ready() -> void:
	Global.RAGEMETER = %RageMeter
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		SceneTransition.transition_to_scene("res://going_birdserk_ready.tscn")
		AudioManager.stop_music()
