extends Lootable
class_name ExpDrop

export var value = 1

func PickUp(character):
	var expValue = value
	character.GiveExp(expValue)
