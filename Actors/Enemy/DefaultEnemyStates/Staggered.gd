extends State
class_name Staggered

export var staggered_time_seconds = 0.1
var seconds_passed = 0


func Enter(object:MovementAI):
	seconds_passed = 0
	object.MoveTowardPlayer(-5)


func Exit(object:MovementAI):
	pass


func InputUpdate(event, object:MovementAI, _delta):
	if object.death:
		return stateDictionary["Death"]
	if staggered_time_seconds < seconds_passed:
		return stateDictionary["IdleAI"]


func Update(object:MovementAI, delta):
	seconds_passed += delta

