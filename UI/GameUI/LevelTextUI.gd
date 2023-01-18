extends Label
func _on_ExperienceSystem_gainedExperience(maximumExp, currentExp):
	text = _exp_text(currentExp, maximumExp)


func _on_ExperienceSystem_leveledup(maximumExp, level):
	text = _exp_text(0, maximumExp)

func _exp_text(current, maximum):
	return String(current) + "/" + String(maximum)
