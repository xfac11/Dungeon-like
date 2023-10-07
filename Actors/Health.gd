extends Node
class_name Health

signal healthDepleted(parent)
signal damageTaken(health_stat)
signal healed(health_stat)
signal healthSet(health_stat)
var armor = 0
export var maximumHealth = 100
var currentHealth = maximumHealth
var dead:bool = false
onready var parent = get_parent()
func _ready():
	currentHealth = maximumHealth


func TakeDotDamage(damage:int):
	if dead:
		return
	currentHealth -= max(damage-armor, 0)
	if currentHealth <= 0:
		currentHealth = 0
		emit_signal("healthDepleted", parent)
		dead = true

func TakeDamage(damage:int):
	if dead:
		return
	currentHealth -= max(damage-armor, 0)
	if currentHealth <= 0:
		currentHealth = 0
		emit_signal("healthDepleted", parent)
		dead = true
	var hpStat:HealthStat = HealthStat.new()
	hpStat.current_health = currentHealth
	hpStat.maximum_health = maximumHealth
	hpStat.difference = damage-armor
	emit_signal("damageTaken", hpStat)


func SetHealth(newMax:int):
	maximumHealth = newMax
	var hpStat:HealthStat = HealthStat.new()
	hpStat.current_health = currentHealth
	hpStat.maximum_health = maximumHealth
	hpStat.difference = 0
	emit_signal("healthSet", hpStat)


func SetCurrentHealth(health:int):
	currentHealth = health
	var hpStat:HealthStat = HealthStat.new()
	hpStat.current_health = currentHealth
	hpStat.maximum_health = maximumHealth
	hpStat.difference = 0
	emit_signal("healthSet", hpStat)


func Heal(health:int):
	if health <= 0:
		return
	currentHealth = min(currentHealth+health, maximumHealth)
	
	var hpStat:HealthStat
	hpStat.current_health = currentHealth
	hpStat.maximum_health = maximumHealth
	hpStat.difference = health
	emit_signal("healed", hpStat)


func increase_maximum_health(var percent_increase:float):
	maximumHealth = maximumHealth*percent_increase
	currentHealth = maximumHealth
