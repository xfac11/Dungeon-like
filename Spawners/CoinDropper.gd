extends Node
class_name CoinDropper

export(PackedScene) var coinScene

func spawn_coin(position, count, push = 0):
	var _newCoin = create_coins(count, position, push)


func spawn_object(packedScene):
	var object = packedScene.instance()
	get_parent().add_child(object)
	object.transform = get_parent().transform
	return object


func create_coins(count, position, push):
	for i in count:
		var newCoin = spawn_object(coinScene)
		newCoin.position = position
		newCoin.Push(push)


func _on_spawn_coin(position, count, push = 0):
	call_deferred("spawn_coin", position, count, push)
