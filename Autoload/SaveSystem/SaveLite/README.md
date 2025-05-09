# SaveLite for Godot 4

![Godot 4](https://img.shields.io/badge/Godot-4.0-%23478cbf)

**The simplest possible save system** for Godot game jams and prototypes. Auto-saves when your game closes, with zero setup required.

**Perfect when you need to:**
- Save settings/volume
- Keep basic progress between sessions
- Add quick checkpoints
- Avoid save system overengineering

## Quick Start

1. **Add to Autoload:**
   - Copy `SaveLite.gd` to your project
   - Go to *Project → Project Settings → Autoload*
   - Add `SaveLite.gd` as a singleton

2. **Start Saving:**
```gdscript
# Save current volume
SaveLite.save_value("audio", "master_volume", 0.8)

# Load with fallback value
var volume = SaveLite.load_value("audio", "master_volume", 0.5)

# Save player health whenever the value is changed
@export var health := 100:
    set(value):
        health = value
        SaveLite.save_value("player", "health", value) # Auto-save on change

func _ready():
    health = SaveLite.load_value("player", "health", 100)
