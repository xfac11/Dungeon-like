extends State
class_name IdleAI

export var default_direction = Vector2(1,0)
var _damage_taken = false


func _enter(_object:MovementAI):
	pass


func _exit(_object:MovementAI):
	pass


func _inputUpdate(event, object:MovementAI, _delta):
	if object.death:
		return stateDictionary["Death"]
	if _damage_taken:
		_damage_taken = false
		return stateDictionary["Staggered"]
	return null


func _update(object:MovementAI, delta):
	var speed_multiple = 1.0
	if !object.move_toward_player(speed_multiple):
		object.move(default_direction, speed_multiple)


func _on_Health_damageTaken(currentHealth, maximumHealth, damageAmount):
	_damage_taken = true
