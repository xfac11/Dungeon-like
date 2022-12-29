extends State
class_name Run
var mSpeed = 100
func Enter(object:Player):
	object.ChangeColor(Color(0,1,0,1))
func Exit(object:Player):
	object.ChangeColor(Color(1, 1, 1, 1))
func InputUpdate(event:Input, _object:Player, _delta):
	var leftInput = Input.is_action_pressed("move_left")
	var rightInput = Input.is_action_pressed("move_right")
	var upInput = Input.is_action_pressed("move_up")
	var downInput = Input.is_action_pressed("move_down")
	if event.is_action_just_pressed("grounded"):
		return stateDictionary["Grounded"]
	if leftInput || rightInput || upInput || downInput:
		return null
	return stateDictionary["Idle"]
func Update(object:Player, _delta):
	var leftInput = Input.is_action_pressed("move_left")
	var rightInput = Input.is_action_pressed("move_right")
	var upInput = Input.is_action_pressed("move_up")
	var downInput = Input.is_action_pressed("move_down")
	var x:int = int(rightInput) - int(leftInput)
	var y:int = int(downInput) - int(upInput)
	var direction = Vector2(x,y)
	
	object.Move(direction,mSpeed)
