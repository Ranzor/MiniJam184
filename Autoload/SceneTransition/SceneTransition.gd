extends Node

var fade_color := Color.BLACK
var fade_duration := 0.5

var _canvas_layer : CanvasLayer
var _color_rect : ColorRect

func _ready() -> void:
	_canvas_layer = CanvasLayer.new()
	_canvas_layer.layer = 128
	add_child(_canvas_layer)
	
	_color_rect = ColorRect.new()
	_color_rect.anchor_right = 1.0
	_color_rect.anchor_bottom = 1.0
	_color_rect.color = fade_color
	_color_rect.color.a = 0.0
	add_child(_color_rect)
	
	
func transition_to_scene(path : String) -> void:
	var tween = create_tween().set_parallel(false)
	tween.tween_property(_color_rect, "color:a", 1.0, fade_duration)
	await tween.finished
	
	get_tree().change_scene_to_file(path)
	
	tween = create_tween()
	tween.tween_property(_color_rect, "color:a", 0.0, fade_duration)
