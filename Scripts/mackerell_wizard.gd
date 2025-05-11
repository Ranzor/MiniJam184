extends StaticBody2D

enum LANES {TOP, HIGH, MID, LOW}
@export var hp_max : int = 100
@export var projectile_scene: PackedScene
@export var player : CharacterBody2D

@export var beam_pattern_a : PackedScene
@export var beam_pattern_b : PackedScene
@export var beam_pattern_c : PackedScene
@export var beam_pattern_d : PackedScene
@export var beam_pattern_e : PackedScene
@export var sphere_pattern_a : PackedScene
@export var sphere_pattern_b : PackedScene
@export var sphere_pattern_c : PackedScene
@export var hybrid_pattern_a : PackedScene
@export var hybrid_pattern_b : PackedScene

@export var lane_positions: Dictionary = {
	LANES.TOP: Vector2(0,0),
	LANES.HIGH: Vector2(0,0),
	LANES.MID: Vector2(0,0),
	LANES.LOW: Vector2(0,0),
}

@onready var bpm = Beatbox.BPM
@onready var beat_interval = bpm / 60
var current_pattern = []

var hp : int = hp_max:
	set(value):
		hp = value
		Global.HP_BAR.update_hp_bar(hp)

func _ready() -> void:
	Beatbox.connect("beat",on_beat)
	
	$beat_timer.wait_time = beat_interval
	$beat_timer.start()

	%MackerellArea.mackerell = self

	Global.MAX_HP = hp_max

func on_beat():
	var atk
	if Beatbox.total_beats == 5:
		atk = beam_pattern_a.instantiate()
		get_parent().add_child(atk)
		for i in atk.get_children():
			i.set_beat = Beatbox.total_beats
		
	if Beatbox.total_beats == 10:
		atk = beam_pattern_b.instantiate()
		get_parent().add_child(atk)
		for i in atk.get_children():
			i.set_beat = Beatbox.total_beats
	
	if Beatbox.total_beats == 15:
		atk = sphere_pattern_a.instantiate()
		get_parent().add_child(atk)
		for i in atk.get_children():
			i.set_beat = Beatbox.total_beats
			
	if Beatbox.total_beats == 20:
		atk = sphere_pattern_b.instantiate()
		get_parent().add_child(atk)
		for i in atk.get_children():
			i.set_beat = Beatbox.total_beats
			
	if Beatbox.total_beats == 25:
		atk = sphere_pattern_c.instantiate()
		get_parent().add_child(atk)
		for i in atk.get_children():
			i.set_beat = Beatbox.total_beats
			
	if Beatbox.total_beats == 30:
		atk = hybrid_pattern_a.instantiate()
		get_parent().add_child(atk)
		for i in atk.get_children():
			i.set_beat = Beatbox.total_beats
			
	if Beatbox.total_beats == 35:
		atk = hybrid_pattern_b.instantiate()
		get_parent().add_child(atk)
		for i in atk.get_children():
			i.set_beat = Beatbox.total_beats
	
	if Beatbox.total_beats == 40:
		atk = beam_pattern_c.instantiate()
		get_parent().add_child(atk)
		for i in atk.get_children():
			i.set_beat = Beatbox.total_beats
	
	if Beatbox.total_beats == 45:
		atk = beam_pattern_d.instantiate()
		get_parent().add_child(atk)
		for i in atk.get_children():
			i.set_beat = Beatbox.total_beats
	
	if Beatbox.total_beats == 50:
		atk = beam_pattern_e.instantiate()
		get_parent().add_child(atk)
		for i in atk.get_children():
			i.set_beat = Beatbox.total_beats

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
	hp -= damage
	
func _process(_delta: float) -> void:
	if player.position.x > position.x:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
