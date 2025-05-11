extends MarginContainer
@export var credits_screen: VBoxContainer


@export var continue_game_button: Button
@export var new_game_button: Button
@export var options_button: Button
@export var quit_button: Button
@export var toggle_credits_return_button: Button
@export var toggle_credits_open_button: Button

var main_menu_buttons: Array
var return_buttons: Array
var credits_buttons

func _ready():
	AudioManager.play_music(preload("res://Audio/devMenu.wav"))
	main_menu_buttons = [new_game_button,quit_button]
	return_buttons = [toggle_credits_return_button]
	credits_buttons = [toggle_credits_open_button]
func _process(delta):
	update_button_scale()

func update_button_scale():
	for button in main_menu_buttons:
		button_hover(button, 1.2, 0.5)
	for button in return_buttons:
		button_hover(button, 1.3, 0.2)
	for button in credits_buttons:
		button_hover(button, 1.2, 0.3)
		

func button_hover(button: Button, tween_amount, duration):
	button.pivot_offset = button.size/2
	if button.is_hovered():
		tween(button, "scale", Vector2.ONE * tween_amount, duration)
	else:
		tween(button,"scale",Vector2.ONE, duration)

func tween(button, property, amount, duration):
	var tween = create_tween()
	tween.tween_property(button, property, amount, duration)


func toggle_visibility(object):
	var animation = $AnimationPlayer
	var animation_type: String
	if object.visible:
		animation_type = "close_"
	else:
		animation_type = "open_"
		
	print(animation_type + str(object.name))
	animation.play(animation_type + str(object.name))

func _on_new_game_button_pressed():
	SceneTransition.transition_to_scene("res://level_1.tscn")
	Beatbox.reset()


func _on_quit_button_pressed():
	get_tree().quit()


func _on_toggle_credits_button_pressed():
	toggle_visibility(credits_screen)
