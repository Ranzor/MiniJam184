extends Node2D

signal beat

@export var BPM = 100
@onready var beat_interval = BPM / 60
var beat_timer = 0.0
var beat_count = 0

var timer
var countdown = 60


func _ready() -> void:
	timer = Timer.new()
	timer.connect("timeout",_on_timer_timeout)
	timer.set_wait_time(1)
	add_child(timer)
	
func _on_timer_timeout():
	countdown -= 1
	$Label2.text = str(countdown)
	if countdown <= 0:
		SceneTransition.transition_to_scene("res://UI/MainMenu/main_menu.tscn")
		timer.stop()
	

func _process(delta: float) -> void:
	beat_timer += delta
	if beat_timer >= beat_interval:
		beat_timer = 0.0
		beat_count += 1
		if beat_count > 4:
			beat_count = 1
		beat.emit()
	$Label.text = str(beat_count)

func reset():
	countdown = 60
	beat_count = 0
	timer.start()
