extends ProgressBar
func _on_ExperienceSystem_gained_experience(maximumExp, currentExp):
	if(currentExp >= maximumExp):
		value = 0
	else:
		var procentExp = currentExp/maximumExp
		var newValue = 100.0 * procentExp
		value = newValue
		
		

func _on_ExperienceSystem_gained_level(maximum_exp, level):
	value = 0
