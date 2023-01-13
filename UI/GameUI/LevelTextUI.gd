extends Label
func _on_ExperienceSystem_gainedExperience(maximumExp, currentExp):
	text = String(currentExp) + "/" + String(maximumExp)
