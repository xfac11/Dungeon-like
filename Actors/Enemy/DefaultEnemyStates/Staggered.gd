extends State
class_name Staggered

export var staggered_time_seconds = 0.1
var seconds_passed = 0
var _player:Player
func _enter(object:Enemy):
	seconds_passed = 0
	if !object.movement.move_toward_object(-5, _player):
		print_debug("_player not defined")


func _exit(object:Enemy):
	pass


func _inputUpdate(event, object:Enemy, _delta):
	if object.health.dead:
		return stateDictionary["Death"]
	if staggered_time_seconds < seconds_passed:
		return stateDictionary["ChasePlayer"]


func _update(_object:Enemy, delta):
	seconds_passed += delta


func set_player(player:Player):
	_player = player

