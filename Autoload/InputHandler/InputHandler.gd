extends Node

signal action_pressed(action: String, strengt: float)
signal action_released(action: String)

var pressed_actions : Dictionary = {}

func _input(event: InputEvent) -> void:
	
	for action in InputMap.get_actions():
		if event.is_action(action):
			if event.is_pressed():
				pressed_actions[action] = true
				action_pressed.emit(action, event.get_action_strength(action))
			else:
				pressed_actions[action] = false
				action_released.emit(action)


func register_action(action: String, default_events : Array[InputEvent]) -> void:

	if not InputMap.has_action(action):
		InputMap.add_action(action)
		
	if InputMap.action_get_events(action).is_empty():
		for event in default_events:
			InputMap.action_add_event(action,event)
