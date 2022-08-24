extends Node
enum IncreaseMethod {ADDITIVE, MULTIPLE}
var experiencePoints = 0
var level = 1
export var maximumExp = 10.0
export var increase = 10.0
export(IncreaseMethod) var increaseMethod = IncreaseMethod.ADDITIVE
signal leveledup(maximumExp, level)
signal gainedExperience(maximumExp, currentExp)


func AddExperience(var experience):
	experiencePoints += experience
	print(experiencePoints)
	emit_signal("gainedExperience", maximumExp, experiencePoints)
	if experiencePoints >= maximumExp:
		experiencePoints = 0
		IncreaseMaximum()
		LevelUp()

func IncreaseMaximum():
	if increaseMethod == IncreaseMethod.ADDITIVE:
		maximumExp+=increase
	elif increaseMethod == IncreaseMethod.MULTIPLE:
		maximumExp*=increase

func LevelUp():
	level += 1
	emit_signal("leveledup",maximumExp, level)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_T:
			AddExperience(3)



func _on_PickUpArea_pickUpSignal(_layer, _body):
		AddExperience(5)
