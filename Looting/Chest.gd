extends Lootable
class_name Chest

signal ChestPickedUp(chest)
func PickUp(character):
	emit_signal("ChestPickedUp", self)

func Traveling(area, delta):
	pass
