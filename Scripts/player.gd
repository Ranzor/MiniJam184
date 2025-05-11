extends CharacterBody2D

@export var speed = 300
@export var jump_force = -400
@export var double_jump_force = -350
@export var gravity = 1200
## We divide the beat inverval by this to get the delay for the beat hit. So hight number = lower delay
@export var beat_hit_delay : float = 2

@export var base_damage = 1
@export var attack_on_beat_multiplier_value = 1.0
@export var attack_on_beat_multiplier_base = 1.0
@export var attack_on_beat_ramping_pace = 5
@export var attack_on_beat_ramping_increase = 0.5
@export var rage_multiplier_modifier = 1

var can_double_jump = false

var beat_timer = 0.0
@onready var bpm = Beatbox.BPM
@onready var beat_interval : float = bpm / 60.0

var is_attacking = false

var target_right : Node2D
var target_left : Node2D
var attacking_right : bool = true
var attack_on_beat_multiplier : float = 1
var attack_on_beat_ramping_value : float = 0.0

var combo_timer_bar : Control
var on_beat = false
var beat : int = 1

var rage_counter : int = 0
var rage_meter : Control

func _ready() -> void:
	Beatbox.connect("beat", on_beat_toggle)
	Global.PLAYER = self

func on_beat_toggle():
	on_beat = true
	beat += 1
	if beat > 4:
		beat = 1
	await get_tree().create_timer(beat_interval/2.0).timeout
	on_beat = false

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
		attacking_right = true
	elif velocity.x < 0 and not is_attacking:
		$Sprite2D.flip_h = true
		attacking_right = false

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
	elif Input.is_action_pressed("duck") and is_on_floor() and not is_attacking:
			$Sprite2D.play("duck")
	elif Input.is_action_just_released("duck") and not is_attacking:
		$CollisionShape2D.scale.y = 1.0
		
	if Input.is_action_just_pressed("attack"):
		$Sprite2D.play("attack")
		is_attacking = true
		deal_damage()
		await $Sprite2D.animation_finished
		is_attacking = false
		
	move_and_slide()

	check_rage()

func check_rage():

	if rage_meter == null:
		rage_meter = Global.RAGEMETER

	if Beatbox.countdown <= 45 and rage_counter == 0:
		rage_counter += 1
		%rage_1_particle.emitting = false
		%rage_2_particle.emitting = true
	elif Beatbox.countdown <= 30 and rage_counter == 1:
		rage_counter += 1
		%rage_2_particle.emitting = false
		%rage_3_particle.emitting = true
	elif Beatbox.countdown <= 15 and rage_counter == 2:
		rage_counter += 1
		%rage_3_particle.emitting = false
		%rage_4_particle.emitting = true

	rage_meter.toggle_rage_meter(rage_counter)

func deal_damage():
	if target_right:
		deal_damage_to_target(target_right)
	if target_left:
		deal_damage_to_target(target_left)

func deal_damage_to_target(target : Node2D):
	if on_beat:
		attack_on_beat_multiplier *= increase_attack_bonus()
	else:
		attack_on_beat_multiplier = 0
		attack_on_beat_ramping_value = 0
		Global.combo += 1

	target.take_damage(base_damage + attack_on_beat_multiplier)
	
func increase_attack_bonus() -> float:
	Global.combo += 2

	if Global.combo % attack_on_beat_ramping_pace == 0:
		attack_on_beat_ramping_value += attack_on_beat_ramping_increase

	attack_on_beat_multiplier = attack_on_beat_multiplier_base + (attack_on_beat_multiplier_value * (Global.combo+attack_on_beat_ramping_value)) * (1 + (rage_counter*rage_multiplier_modifier))
	
	return attack_on_beat_ramping_value + attack_on_beat_multiplier_value


func beat_action(action_type):
	# TODO: Make fancy perfect timing effects
	return

func _on_area_2d_area_entered_left(area : Area2D) -> void:
	if area.is_in_group("mackerell"):
		target_left = area.get_mackerell()

func _on_area_2d_area_exited_left(area : Area2D) -> void:
	if area.is_in_group("mackerell"):
		target_left = null

func _on_area_2d_area_entered_right(area : Area2D) -> void:
	if area.is_in_group("mackerell"):
		target_right = area.get_mackerell()
		
func _on_area_2d_area_exited_right(area : Area2D) -> void:
	if area.is_in_group("mackerell"):
		target_right = null
