extends ProgressBar
func _on_ExperienceSystem_gainedExperience(maximumExp, currentExp):
	if(currentExp >= maximumExp):
		value = 0
	else:
		var procentExp = currentExp/maximumExp
		var newValue = 100*procentExp
		print(newValue)
		print("Hejsan/n")
		value = newValue
		
		
