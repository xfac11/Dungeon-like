class_name ExperienceSystem
extends Node

signal gained_level(maximum_exp, level)
signal gained_experience(maximum_exp, current_exp)

enum IncreaseMethod {ADDITIVE, MULTIPLE}

export var maximum_exp = 10.0
export var increase = 10.0
export(IncreaseMethod) var increase_method = IncreaseMethod.ADDITIVE

var experience_points = 0
var level = 1


func add_experience(var experience):
	experience_points += experience
	emit_signal("gained_experience", maximum_exp, experience_points)
	if experience_points >= maximum_exp:
		experience_points = 0
		_increase_maximum_experience()
		_level_up()


func _increase_maximum_experience():
	if increase_method == IncreaseMethod.ADDITIVE:
		maximum_exp += increase
	elif increase_method == IncreaseMethod.MULTIPLE:
		maximum_exp *= increase


func _level_up():
	level += 1
	emit_signal("gained_level",maximum_exp, level)
