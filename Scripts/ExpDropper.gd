extends Node
class_name ExpDropper

export(PackedScene) var expDrop
export(PackedScene) var expDrop5

func spawn_exp_drop(position, count):
	var newDrop = create_exp_drop(count)
	newDrop.position = position


func spawn_object(packedScene):
	var object = packedScene.instance()
	get_parent().add_child(object)
	object.transform = get_parent().transform
	return object


func create_exp_drop(count):
	if count < 5:
		return spawn_object(expDrop)
	elif count < 10:
		return spawn_object(expDrop5)


func _on_Special_spawn_exp(position, count):
	call_deferred("spawn_exp_drop", position, count)
