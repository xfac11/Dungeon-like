extends ProgressBar
onready var hpText = $HPtext
func UpdateHealthBar(maximumHealth:float, currentHealth:float):
	var procentExp = currentHealth/maximumHealth
	var newValue = 100*procentExp
	value = newValue

func UpdateHealthText(maximumHealth:float, currentHealth:float):
	hpText.text = String(currentHealth) + " / " + String(maximumHealth)

func _on_Health_damageTaken(currentHealth, maximumHealth):
	UpdateHealthBar(maximumHealth, currentHealth)
	UpdateHealthText(maximumHealth, currentHealth)
