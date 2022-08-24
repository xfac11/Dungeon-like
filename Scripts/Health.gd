extends Node
class_name Health

signal healthDepleted()
signal damageTaken(currentHealth, maximumHealth)

export var maximumHealth = 100
var currentHealth = maximumHealth
var dead:bool = false
func TakeDamage(damage:int):
	if dead:
		return
	currentHealth -= damage
	if currentHealth <= 0:
		currentHealth = 0
		emit_signal("healthDepleted")
		dead = true
	emit_signal("damageTaken", currentHealth, maximumHealth)

func SetHealth(newMax:int):
	maximumHealth = newMax
	emit_signal("damageTaken", currentHealth, maximumHealth)
func SetCurrentHealth(health:int):
	currentHealth = health
	emit_signal("damageTaken", currentHealth, maximumHealth)
func Heal(health:int):
	if health <= 0:
		return
	currentHealth = min(currentHealth+health,maximumHealth)
	emit_signal("damageTaken", currentHealth, maximumHealth)
