extends Node
class_name Health

signal healthDepleted(parent)
signal damageTaken(currentHealth, maximumHealth, damageAmount)
signal healed(currentHealth, maximumHealth, healedAmount)
signal healthSet(currentHealth, maximumHealth)
var armor = 0
export var maximumHealth = 100
var currentHealth = maximumHealth
var dead:bool = false
onready var parent = get_parent()
func _ready():
	currentHealth = maximumHealth


func TakeDamage(damage:int):
	if dead:
		return
	currentHealth -= max(damage-armor, 0)
	if currentHealth <= 0:
		currentHealth = 0
		emit_signal("healthDepleted", parent)
		dead = true
	emit_signal("damageTaken", currentHealth, maximumHealth, damage-armor)


func SetHealth(newMax:int):
	maximumHealth = newMax
	emit_signal("healthSet", currentHealth, maximumHealth)


func SetCurrentHealth(health:int):
	currentHealth = health
	emit_signal("healthSet", currentHealth, maximumHealth)


func Heal(health:int):
	if health <= 0:
		return
	currentHealth = min(currentHealth+health, maximumHealth)
	emit_signal("healed", currentHealth, maximumHealth, health)
