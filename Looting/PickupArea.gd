extends Node2D
class_name PickupArea
export var speed:float = 1.0
var pickables = Array()
var mCharacter

func SetCharacter(character):
	mCharacter = character

func _on_Area2D_area_entered(area:Lootable):
	if !area.picked:
		pickables.append(area)
		area.picked = true
func _physics_process(delta):
	for pickable in pickables:
		if is_instance_valid(pickable):
			pickable.Traveling(self, delta)

func _on_Pickup_area_entered(area:Lootable):
	if is_instance_valid(mCharacter):
		area.PickUp(mCharacter)
	else:
		print_debug("No character set for PickupArea", self)
	area.queue_free()
	for object in pickables:
		if !is_instance_valid(object):
			pickables.erase(object)
