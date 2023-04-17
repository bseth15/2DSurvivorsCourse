extends CanvasLayer

signal transitioned_halfway


func transition():
	transition_in()


func transition_in():
	$ColorRect.visible = true
	$AnimationPlayer.play("default")
	await $AnimationPlayer.animation_finished
	transitioned_halfway.emit()
	transition_out()


func transition_out():
	$AnimationPlayer.play_backwards("default")
	await $AnimationPlayer.animation_finished
	$ColorRect.visible = false


func transition_to_scene(scene_path: String):
	transition()
	await transitioned_halfway
	get_tree().change_scene_to_file(scene_path)


func emit_transitioned_halfway():
	transitioned_halfway.emit()
