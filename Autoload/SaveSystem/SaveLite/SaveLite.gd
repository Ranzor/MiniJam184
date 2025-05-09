extends Node

const SAVE_PATH := "user://savelite.cfg"
var _config := ConfigFile.new()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_all()		
func save_all() -> void:
	_config.save(SAVE_PATH)	
func save_value(section: String, key: String, value) -> void:
	_config.set_value(section, key, value)
func load_value(section: String, key: String, default):
	_config.load(SAVE_PATH)
	return _config.get_value(section, key, default)
