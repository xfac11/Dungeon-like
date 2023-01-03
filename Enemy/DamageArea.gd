extends Area2D

onready var timer = $Timer
var player
var IsNearPlayer = false
export var damage = 10

func _on_DamageArea_body_entered(body):
	player = body
	IsNearPlayer = true
	timer.start()
	player.get_node("Health").TakeDamage(damage)

func _on_Timer_timeout():
	if IsNearPlayer:
		player.get_node("Health").TakeDamage(damage)
	else:
		timer.stop()

func _on_DamageArea_body_exited(_body):
	IsNearPlayer = false
