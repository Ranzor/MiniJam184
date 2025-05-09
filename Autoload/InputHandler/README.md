# InputHandler Module
**Centralized input management system for Godot 4 projects**

## Features
- Dynamic input action registration
- Global input event signals
- Pressed action state tracking
- Default keybind fallback system
- Godot InputMap integration

## Installation
1. Add `InputHandler.gd` to your project
2. Set up as autoload:
   - Go to *Project → Project Settings → Autoload*
   - Add `InputHandler.gd` with name **`InputHandler`**

## Basic Usage
### Registering Actions
```gdscript
# Register action with default inputs
var jump_events = [InputEventKey.new(KEY_SPACE)]
InputHandler.register_action("jump", jump_events)
