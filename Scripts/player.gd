extends CharacterBody2D

@export var speed = 300
@export var jump_force = -400
@export var double_jump_force = -350
@export var gravity = 1200
var can_double_jump = false

var beat_timer = 0.0
@export var bpm = 100
@onready var beat_interval = bpm / 60


func _physics_process(delta: float) -> void:
	velocity.x = Input.get_axis("move_left", "move_right") * speed
	velocity.y += gravity * delta
	
	if velocity.x != 0:
		$Sprite2D.play("run")
	else:
		$Sprite2D.play("default")
		
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	elif velocity.x < 0:
		$Sprite2D.flip_h = true

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_force
			can_double_jump = true
			beat_action("jump")
		elif can_double_jump:
			velocity.y = double_jump_force
			can_double_jump = false
			beat_action("double_jump")
			
	if Input.is_action_just_pressed("duck") and is_on_floor():
		$CollisionShape2D.scale.y = 0.5
		beat_action("duck")
	elif Input.is_action_just_released("duck"):
		$CollisionShape2D.scale.y = 1.0
		
	move_and_slide()
	
func beat_action(action_type):
	# TODO: Make fancy perfect timing effects
	return
