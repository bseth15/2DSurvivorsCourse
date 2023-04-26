extends Node

const BASE_RANGE = 150
const BASE_DAMAGE = 15

@export var anvil_ability_scene: PackedScene

var anvils_to_spawn = 1


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func spawn_anvil():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return

	var direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (direction * randf_range(0, BASE_RANGE))

	var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1 << 0)
	var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
	if not result.is_empty():
		spawn_position = result["position"]

	var anvil_ability = anvil_ability_scene.instantiate()
	get_tree().get_first_node_in_group("foreground_layer").add_child(anvil_ability)
	anvil_ability.global_position = spawn_position
	anvil_ability.hitbox_component.damage = BASE_DAMAGE


func on_timer_timeout():
	for i in anvils_to_spawn:
		spawn_anvil()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if  upgrade.id == "anvil_count":
		anvils_to_spawn += 1
