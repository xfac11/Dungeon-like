extends Area2D

onready var timer = $Timer
onready var outTimer = $OutTimer
export var damage = 100
onready var ownBody = get_parent().get_parent().get_node("Body")


func _on_Timer_timeout():
	monitoring = true
	visible = true
	outTimer.start()


func _on_OutTimer_timeout():
	monitoring = false
	visible = false


func _on_MeleeWeapon_body_entered(body):
	var health = body.get_node("Health")
	if health:
		health.TakeDamage(damage)
	
