extends CharacterBody2D

@onready var velocity_component: Node = $VelocityComponent
@onready var visuals: Node2D = $Visuals

var is_moving = false


func _ready() -> void:
	$HurtboxComponent.hit.connect(on_hit)


func _process(delta: float) -> void:
	if is_moving:
		velocity_component.accelerate_to_player()
	else:
		velocity_component.decelerate()

	velocity_component.move(self)

	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)


func set_is_moving(moving: bool) -> void:
	is_moving = moving


func on_hit():
	$HitPlayerRandomAudioComponent.play_random()
