extends Area2D

@export var speed = 200
@export var damage = 1


func _process(delta: float) -> void:
	position.x -= speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.combo -= damage
