extends Node
class_name ExperienceSystem
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
