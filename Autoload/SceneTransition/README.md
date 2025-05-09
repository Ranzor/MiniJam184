# SceneTransition for Godot 4

![Godot 4](https://img.shields.io/badge/Godot-4.0-%23478cbf)

**Zero-setup scene transitions** for Godot projects. Create polished fades/wipes between scenes with one line of code - perfect for game jams and prototypes.


## Features

- **Plug-and-play** - No scene setup required

## Installation

1. Add `SceneTransition.gd` as an autoload:
   - Go to **Project → Project Settings → Autoload**
   - Set Path: `res://path/to/SceneTransition.gd`
   - Set Name: `SceneTransition`

2. *Usage:
   ```gdscript
# From any script:
SceneTransition.transition_to_scene("res://level_2.tscn")
