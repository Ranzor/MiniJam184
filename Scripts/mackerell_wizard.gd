extends StaticBody2D

enum LANES {TOP, HIGH, MID, LOW}
@export var projectile_scene: PackedScene

@export var lane_positions: Dictionary = {
	LANES.TOP: Vector2(0,0),
	LANES.HIGH: Vector2(0,0),
	LANES.MID: Vector2(0,0),
	LANES.LOW: Vector2(0,0),
}

@export var bpm = 100
var beat_interval = bpm / 60
var current_pattern = []


func _ready() -> void:
	$beat_timer.wait_time = beat_interval
	$beat_timer.start()
	



func _on_beat_timer_timeout() -> void:
	if current_pattern.is_empty():
		#fire_projectile(LANES.values().pick_random())
		pass
	else:
		# More pattern stuff
		pass
	
func fire_projectile(lane: LANES):
	var proj = projectile_scene.instantiate()
	proj.position = global_position + lane_positions[lane]
	proj.target_line = lane
	get_parent().add_child(proj)
	
