extends Sprite2D
var set_beat = 2
var target_beat = 0
@export var tele : Texture2D
@export var atk : Texture2D


func _ready() -> void:
	texture = tele


func _process(delta: float) -> void:
	
	target_beat = set_beat + 2
	if target_beat > 4:
		target_beat -= 4
	
	if Beatbox.beat_count == target_beat:
		texture = atk
	
	if Beatbox.beat_count == set_beat and texture == atk:
		queue_free()
