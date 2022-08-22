extends TextureProgress

func UpdateHealthBar(maximumHealth:float, currentHealth:float):
	var procentExp = currentHealth/maximumHealth
	var newValue = 100*procentExp
	value = newValue


func _on_Health_damageTaken(currentHealth, maximumHealth):
	UpdateHealthBar(maximumHealth, currentHealth)
