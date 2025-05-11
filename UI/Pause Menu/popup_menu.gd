extends MarginContainer

@export var menu_screen: VBoxContainer
@export var open_menu_screen: VBoxContainer
@export var help_menu_screen: MarginContainer
@export var options_menu_screen: MarginContainer

@export var open_menu_button: Button
@export var close_menu_button: Button #This is an in-menu button despite the name
@export var open_help_button: Button
@export var close_help_button: Button
@export var open_options_button: Button
@export var close_options_button: Button
@export var open_mainMenu_button: Button
@export var open_quitGame_button: Button

var in_menu_buttons: Array
var close_menu_buttons: Array
var toggle_popupmenu_buttons: Array

func _ready():
	in_menu_buttons = [close_menu_button, open_help_button, open_options_button, open_mainMenu_button,open_quitGame_button]
	toggle_popupmenu_buttons = [open_menu_button] # Will add more button functionality in lower left quick menu items, left as array
	close_menu_buttons = [close_help_button, close_options_button] 


func _process(delta):
	update_button_scale()
	if Input.is_action_just_pressed("pause"):
		toggle_visibility(menu_screen)

func update_button_scale():
	for button in in_menu_buttons:
		button_hover(button, 1.2, 0.5)
	for button in toggle_popupmenu_buttons:
		button_hover(button, 1.5, 0.2)
	for button in close_menu_buttons:
		button_hover(button, 1.2, 0.2)

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
		
	animation.play(animation_type + str(object.name))




func _on_toggle_menu_button_pressed():
	toggle_visibility(menu_screen)


func _on_toggle_help_menu_pressed():
	toggle_visibility(help_menu_screen)


func _on_toggle_options_menu_pressed():
	
	toggle_visibility(options_menu_screen)


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("main_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
