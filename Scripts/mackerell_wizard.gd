extends StaticBody2D

enum LANES {TOP, HIGH, MID, LOW}
@export var projectile_scene: PackedScene
@export var sphere_mid : PackedScene

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

	%MackerellArea.mackerell = self
	

func on_beat():
	var atk = spawn_in_view(sphere_mid)
	atk.set_beat = Beatbox.beat_count
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
	
func spawn_in_view(scene: PackedScene, padding: float = 50.0) -> Sprite2D:
	var camera = get_viewport().get_camera_2d()
	var viewport_size = get_viewport().get_visible_rect().size
	var visible_rect = Rect2(camera.global_position - viewport_size/(2 * camera.zoom), viewport_size/camera.zoom)
	
	var spawn_pos = Vector2(
		randf_range(visible_rect.position.x + padding, visible_rect.end.x - padding),
		randf_range(visible_rect.position.y + padding, visible_rect.end.y - padding)
	)
	
	var instance = scene.instantiate()
	instance.global_position = spawn_pos
	get_parent().add_child(instance)
	
	return instance
	
func take_damage(damage: int) -> void:
	# Handle damage logic here
	print("Mackerell took damage: ", damage)
	
