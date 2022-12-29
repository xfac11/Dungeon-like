extends Lootable
class_name Coin

export var value = 1
var acc = 1
signal PickedUpCoin(value)

func PickUp(character):
	var coin = value
	character.GiveCoin(coin)
	emit_signal("PickedUpCoin", coin)

func Traveling(area, delta):
	var areaPos = area.global_position
	var direction = areaPos - global_position
	global_position += direction.normalized() * (area.speed/weight) * delta * acc
	acc += 1 * delta
