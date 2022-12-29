extends State
class_name Shooting
var seconds = 0
onready var tween = $Tween
export(float) var totalSeconds = 1
export(Vector2) var scaleFrom = Vector2(0.5,0.5)
#START For editor
var conditions = []
class Condition:
	var test:FuncRef
	var toState:String
func ShootingDone(): 
	return seconds >= totalSeconds
#END
func AddCondition(function,toState):
	var cond = Condition.new()
	cond.test = function
	cond.toState = toState
	conditions.append(cond)
func _ready():
	#START For editor
	AddCondition(funcref(self, "ShootingDone"),"Grounded")
	#END
func Enter(object:Player):
	var mousePos = object.GetMousePos()
	var direction = mousePos - object.position
	direction = direction.normalized() * 10
	tween.interpolate_property(object, "position",
		object.position, object.position - direction, totalSeconds,
		Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween.start()
	seconds = 0
	object.scale = Vector2(0.5,0.5)
	object.ChangeColor(Color(1,0,0,1))
	
func Exit(object:Player):
	object.ChangeColor(Color(1,1,1,1))
	object.scale = Vector2(1,1)
func InputUpdate(_event:Input, _object:Player, _delta):
	
	#This can later be used to create an editor for state transitions and their conditons
	for condition in conditions:
		if condition.test.call_func():
			return stateDictionary[condition.toState]
	
		#return stateDictionary["Grounded"]
	return null
func Update(_object:Player, delta):
	seconds+=delta
