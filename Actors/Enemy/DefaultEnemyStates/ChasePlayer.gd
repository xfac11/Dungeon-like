class_name ChasePlayer
extends State

var _player:Player
var damage_taken = false
func _enter(_object):
	damage_taken = false


func _exit(_object):
	pass


func _inputUpdate(_event, object:Enemy, _delta):
	if object.health.dead == true:
		return stateDictionary["Death"]
	if damage_taken == true:
		return stateDictionary["Staggered"]
	return null


func _update(object:Enemy, _delta):
	if !object.movement.move_toward_object(1.0, _player):
		print_debug("Player not defined")


func set_player(player:Player):
	_player = player


func connect_health(health:Health):
	var err = health.connect("damageTaken", self, "_on_Health_damageTaken")
	return err


func _on_Health_damageTaken(_currentHealth, _maximumHealth, _damageAmount):
	damage_taken = true
