extends Node2D

signal beat

@export var BPM = 100
@onready var beat_interval = BPM / 60
var beat_timer = 0.0
var beat_count = 0


func _process(delta: float) -> void:
	beat_timer += delta
	if beat_timer >= beat_interval:
		beat_timer = 0.0
		beat_count += 1
		if beat_count > 4:
			beat_count = 1
		beat.emit()
	$Label.text = str(beat_count)
