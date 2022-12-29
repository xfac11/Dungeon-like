extends State
class_name Grounded
func Enter(object:Player):
	object.ChangeColor(Color(0,0,1,1))
	object.scale = Vector2(0.8, 0.8)
func Exit(object:Player):
	object.ChangeColor(Color(1,1,1,1))
	object.scale = Vector2(1, 1)
func InputUpdate(event:Input, _object:Player, _delta):
	if event.is_action_just_pressed("grounded"):
		return stateDictionary["Idle"]
	if event.is_action_pressed("shoot"):
		return stateDictionary["Shooting"]
	return null
func Update(_object:Player, _delta):
	pass
