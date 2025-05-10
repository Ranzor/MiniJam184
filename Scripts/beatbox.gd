extends Node2D

signal beat

@export var BPM = 100
@onready var beat_interval = 60.0 / BPM
var beat_timer = 0.0
var beat_count = 0

var timer
var countdown = 60


func _ready() -> void:
	timer = Timer.new()
	timer.connect("timeout",_on_timer_timeout)
	timer.set_wait_time(1.0)
	add_child(timer)
	timer.start()
	
func _on_timer_timeout():
	countdown -= 1
	$Label2.text = str(countdown)
	if countdown <= 0:
		SceneTransition.transition_to_scene("res://UI/MainMenu/main_menu.tscn")
		timer.stop()
	

func _process(delta: float) -> void:
	beat_timer += delta
	if beat_timer >= beat_interval:
		var beats_passed = floor(beat_timer / beat_interval)
		beat_timer = fmod(beat_timer, beat_interval)
		
		for b in beats_passed:
			beat_count = (beat_count % 4) + 1
			beat.emit()
			$Label.text = str(beat_count)
		beat_timer = 0.0
		

func reset():
	countdown = 60
	beat_count = 0
	timer.start()
