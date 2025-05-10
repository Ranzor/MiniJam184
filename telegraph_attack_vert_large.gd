extends Sprite2D

var set_beat = 2
var target_beat = 0
@export var tele : Texture2D
@export var atk : Texture2D

var can_hit = false


func _ready() -> void:
	texture = tele
	position.y = -169


func _process(delta: float) -> void:
	
	target_beat = set_beat + 2
	
	if Beatbox.total_beats == target_beat:
		if can_hit:
			Global.combo = 0
			can_hit = false
			pass
		for i in get_children():
			i.texture = atk
	
	if Beatbox.total_beats == target_beat + 1:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_hit = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_hit = false
