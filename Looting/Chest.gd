extends Lootable
class_name Chest

signal ChestPickedUp
func PickUp(character):
	emit_signal("ChestPickedUp")

func Traveling(area, delta):
	pass
