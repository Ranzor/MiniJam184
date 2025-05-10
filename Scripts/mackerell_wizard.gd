extends StaticBody2D

enum LANES {TOP, HIGH, MID, LOW}
@export var projectile_scene: PackedScene

@export var lane_positions: Dictionary = {
	LANES.TOP: Vector2(0,0),
	LANES.HIGH: Vector2(0,0),
	LANES.MID: Vector2(0,0),
	LANES.LOW: Vector2(0,0),
}

@onready var bpm = Beatbox.BPM
@onready var beat_interval = bpm / 60
var current_pattern = []


func _ready() -> void:
	Beatbox.connect("beat",on_beat)
	
	$beat_timer.wait_time = beat_interval
	$beat_timer.start()
	

func on_beat():
	print("beat")
	if current_pattern.is_empty() and Beatbox.beat_count == 2:
		fire_projectile(LANES.values().pick_random())
	else:
		# More pattern stuff
		pass
	pass

	
func fire_projectile(lane: LANES):
	var proj = projectile_scene.instantiate()
	proj.position = lane_positions[lane]
	get_parent().add_child(proj)
	
