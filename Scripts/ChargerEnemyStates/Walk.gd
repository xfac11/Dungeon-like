extends State
class_name Walk
export var direction = Vector2(1,0)
export var radius = 100
func Enter(_object:MovementAI):
	pass
func Exit(_object:MovementAI):
	pass
func InputUpdate(event, object:MovementAI, _delta):
	if object.IsCloseToPlayer(radius):
		return stateDictionary["Charge"]
	return null
func Update(object:MovementAI, delta):
	var speedMultiple = 1.0
	if !object.MoveTowardPlayer(speedMultiple):
		object.Move(direction,speedMultiple)
