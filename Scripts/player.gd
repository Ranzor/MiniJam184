extends CharacterBody2D

@export var speed = 300
@export var jump_force = -400
@export var double_jump_force = -350
@export var gravity = 1200
var can_double_jump = false

var beat_timer = 0.0
@onready var bpm = Beatbox.BPM
@onready var beat_interval = bpm / 60

var is_attacking = false


func _physics_process(delta: float) -> void:
	velocity.x = Input.get_axis("move_left", "move_right") * speed
	velocity.y += gravity * delta
	
	if velocity.y > 0 and not is_on_floor() and not is_attacking:
		$Sprite2D.play("fall")
	
	if velocity.x != 0 and is_on_floor() and not is_attacking:
		$Sprite2D.play("run")
	elif velocity.x == 0 and is_on_floor() and not is_attacking:
		$Sprite2D.play("default")
		
	if velocity.x > 0 and not is_attacking:
		$Sprite2D.flip_h = false
	elif velocity.x < 0 and not is_attacking:
		$Sprite2D.flip_h = true

	if Input.is_action_just_pressed("jump") and not is_attacking:
		if is_on_floor():
			velocity.y = jump_force
			can_double_jump = true
			$Sprite2D.play("jump")
			beat_action("jump")
		elif can_double_jump and not is_attacking:
			velocity.y = double_jump_force
			can_double_jump = false
			$Sprite2D.play("double_jump")
			beat_action("double_jump")
			
	if Input.is_action_just_pressed("duck") and is_on_floor() and not is_attacking:
		$CollisionShape2D.scale.y = 0.5
		beat_action("duck")
	elif Input.is_action_just_released("duck") and not is_attacking:
		$CollisionShape2D.scale.y = 1.0
		
	if Input.is_action_just_pressed("attack"):
		$Sprite2D.play("attack")
		is_attacking = true
		await $Sprite2D.animation_finished
		is_attacking = false
		
	move_and_slide()
	
func beat_action(action_type):
	# TODO: Make fancy perfect timing effects
	return
