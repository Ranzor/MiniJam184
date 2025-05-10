extends CharacterBody2D

@export var speed = 300
@export var jump_force = -400
@export var double_jump_force = -350
@export var gravity = 1200
var can_double_jump = false
var dir = 1

var beat_timer = 0.0
@onready var bpm = Beatbox.BPM
@onready var beat_interval = bpm / 60

var is_attacking = false
var bounce = false
var tempdir = 0


func _physics_process(delta: float) -> void:
	velocity.x = dir * speed
	velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("move_left"):
		dir = -1
	elif Input.is_action_just_pressed("move_right"):
		dir = 1
	
	if is_on_wall() and not bounce:
		_bounce()
	if not is_on_wall() and bounce:
		bounce = false
	
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
		tempdir = dir
		dir = 0
	elif Input.is_action_just_released("duck") and not is_attacking:
		$CollisionShape2D.scale.y = 1.0
		dir = tempdir
		
	if Input.is_action_just_pressed("attack"):
		$Sprite2D.play("attack")
		is_attacking = true
		tempdir = dir
		dir = 0
		await $Sprite2D.animation_finished
		is_attacking = false
		dir = tempdir
		
	move_and_slide()
	
func beat_action(action_type):
	# TODO: Make fancy perfect timing effects
	return
	
func _bounce():
	bounce = true
	if dir == 1:
		dir = -1
	else:
		dir = 1
