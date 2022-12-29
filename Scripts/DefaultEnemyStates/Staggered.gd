extends State

class_name Staggered
var seconds = 0
export var staggeredSeconds = 0.1
func Enter(object:MovementAI):
	seconds = 0
	object.MoveTowardPlayer(-5)
func Exit(object:MovementAI):
	pass
func InputUpdate(event, object:MovementAI, _delta):
	if staggeredSeconds < seconds:
		return stateDictionary["IdleAI"]
func Update(object:MovementAI, delta):
	seconds += delta

