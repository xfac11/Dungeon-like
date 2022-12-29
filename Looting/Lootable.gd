extends Area2D
class_name Lootable
export var weight:float = 1.0
var picked = false
## When the player collides with the pickable
func PickUp(_character):
	pass
## When the player is close to the pickable and it begins going towards the player
func Traveling(area, delta):
	var areaPos = area.global_position
	var direction = areaPos - global_position
	global_position += direction.normalized() * (area.speed/weight) * delta
