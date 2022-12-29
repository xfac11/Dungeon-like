extends State
class_name IdleAI
export var direction = Vector2(1,0)
var seconds = 0
var damageTaken = false
func Enter(_object:MovementAI):
	pass
func Exit(_object:MovementAI):
	pass
func InputUpdate(event, object:MovementAI, _delta):
	if damageTaken:
		damageTaken = false
		return stateDictionary["Staggered"]
	return null
func Update(object:MovementAI, delta):
	var speedMultiple = 1.0
	if !object.MoveTowardPlayer(speedMultiple):
		object.Move(direction,speedMultiple)
	object.UpdateAnimation(object.velocity)
func DamageTaken():
	damageTaken = true


func _on_Health_damageTaken(currentHealth, maximumHealth):
	DamageTaken()
