class_name Coin
extends Lootable

export var value = 1
var _acceleration = 1
signal PickedUpCoin(value)

func PickUp(character):
	var coin = value
	character.GiveCoin(coin)
	emit_signal("PickedUpCoin", coin)


func Push(force):
	_acceleration += force


func Traveling(area, delta):
	var areaPos = area.global_position
	var direction = areaPos - global_position
	global_position += direction.normalized() * (area.speed/weight) * delta * _acceleration
	_acceleration += 1 * delta
