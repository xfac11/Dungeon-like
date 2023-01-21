extends Node
class_name ExpDropper

export(PackedScene) var expDrop:PackedScene
export(PackedScene) var expDrop5:PackedScene
onready var parent:Node2D = get_parent()
func spawn_exp_drop(position:Vector2, count:int) -> void:
	var newDrop:Node2D = create_exp_drop(count)
	newDrop.position = position


func spawn_object(packedScene:PackedScene) -> Node2D:
	var object:Node2D = packedScene.instance()
	
	parent.add_child(object)
	object.transform = parent.transform
	
	return object


func create_exp_drop(count:int) -> Node2D:
	var newExpDrop:ExpDrop = spawn_object(expDrop)
	var scale:float = 1 + (count*0.1) - (0.5/count * count)
	newExpDrop.scale = Vector2(scale, scale)
	newExpDrop.value = count
	return newExpDrop


func _on_Special_spawn_exp(position, count) -> void:
	call_deferred("spawn_exp_drop", position, count)
