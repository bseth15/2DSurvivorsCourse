extends CharacterBody2D

const MAX_SPEED: float = 40.0

@onready var health_component: HealthComponent = $HealthComponent
@onready var visuals: Node2D = $Visuals


func _process(delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()

	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(-move_sign, 1)


func get_direction_to_player():
	var player_node: Node2D = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO
