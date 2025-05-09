# AudioManager Module 
**A drag-and-drop global audio system for Godot 4 game jams and prototypes.**

## Features
    **Global access** from any script
    **Music & SFX management** with auto-cleanup
    **Zero scene dependencies** (pure autoload)
    **Volume saving** between sessions
    **Bus controls** (Master/SFX/Music)

## Installation
1. Add `AudioManager.gd` to your project
2. **Set up autoload**:
   - Go to *Project → Project Settings → Autoload*
   - Add `AudioManager.gd` with name **`AudioManager`**

## Basic Usage
```gdscript
# Play a sound effect (creates temporary player)
AudioManager.play_sound(preload("res://sfx/jump.wav"))

# Play background music (auto-stops previous track)
AudioManager.play_music(preload("res://music/level1.ogg"))

# Set volume (0.0-1.0 range)
AudioManager.set_bus_volume("Master", 0.8)
