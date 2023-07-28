extends State
class_name IdleAI

export var default_direction = Vector2(1,0)
var damage_taken = false


func Enter(_object:MovementAI):
	pass


func Exit(_object:MovementAI):
	pass


func InputUpdate(event, object:MovementAI, _delta):
	if object.death:
		return stateDictionary["Death"]
	if damage_taken:
		damage_taken = false
		return stateDictionary["Staggered"]
	return null


func Update(object:MovementAI, delta):
	var speed_multiple = 1.0
	if !object.MoveTowardPlayer(speed_multiple):
		object.Move(default_direction, speed_multiple)


func _on_Health_damageTaken(currentHealth, maximumHealth, damageAmount):
	damage_taken = true
