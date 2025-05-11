extends Node2D

signal beat

@export var BPM = 100
@onready var beat_interval = 60.0 / BPM
var beat_timer = 0.0
var total_beats = 0
var beat_count = 0
var audio_position = 0.0

var timer
var countdown = 60

func _ready() -> void:
	timer = Timer.new()
	timer.connect("timeout",_on_timer_timeout)
	timer.set_wait_time(1.0)
	add_child(timer)
	
func _on_timer_timeout():
	countdown -= 1
	$Label2.text = str(countdown)
	if countdown <= 0:
		AudioManager.stop_music()
		SceneTransition.transition_to_scene("res://UI/MainMenu/main_menu.tscn")
		timer.stop()
	

func _process(delta: float) -> void:
	
	var music_player = AudioManager.get_current_music_player()
	if music_player and music_player.playing:
		audio_position = music_player.get_playback_position() + AudioServer.get_time_since_last_mix()
		
		var current_beat = floor(audio_position / beat_interval)
		var beats_to_process = current_beat - total_beats
		
		for b in range(beats_to_process):
			total_beats += 1
			beat_count = (total_beats % 4) +1
			beat.emit()
			$Label.text = str(beat_count)

func reset():
	countdown = 60
	beat_count = 0
	audio_position = 0.0
	total_beats = 0
	
	AudioManager.play_music(preload("res://Audio/Maakemann.wav"))
	timer.start()
	
	var music_player = AudioManager.get_current_music_player()
	if music_player:
		music_player.play()
