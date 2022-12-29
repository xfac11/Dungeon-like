extends State
class_name Idle
var direction = 1
var seconds = 0
func Enter(_object:Player):
	pass
func Exit(_object:Player):
	pass
func InputUpdate(event:Input, _object:Player, _delta):
	var right = event.is_action_pressed("move_right")
	var left = event.is_action_pressed("move_left")
	var up = event.is_action_pressed("move_up")
	var down = event.is_action_pressed("move_down")
	
	if event.is_action_just_pressed("grounded"):
		return stateDictionary["Grounded"]
	
	if  right || left || up || down:
		return stateDictionary["Run"]
	return null
func Update(object:Player, delta):
	seconds += delta
	object.Move(Vector2(0,direction),5)
	if seconds > 1:
		if direction == 1:
			direction = -1
		else:
			direction = 1
		seconds = 0

