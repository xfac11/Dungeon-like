class_name HealthBar
extends ProgressBar

onready var hpText = $HPtext
func UpdateHealthBar(maximumHealth:float, currentHealth:float):
	var procentExp = currentHealth/maximumHealth
	var newValue = 100*procentExp
	value = newValue

func UpdateHealthText(maximumHealth:float, currentHealth:float):
	hpText.text = String(currentHealth) + " / " + String(maximumHealth)

func update_health_UI(hpStat:HealthStat):
	UpdateHealthBar(hpStat.maximum_health, hpStat.current_health)
	UpdateHealthText(hpStat.maximum_health, hpStat.current_health)
