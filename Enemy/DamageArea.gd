extends Area2D

onready var timer = $Timer
var player
var IsNearPlayer = false
export var damage = 10
var dmgSrc = DamageSource.new()
func _ready():
	dmgSrc.physical = damage
func _on_DamageArea_body_entered(body):
	player = body
	IsNearPlayer = true
	timer.start()
	player.damageTaker.ResolveHit(dmgSrc)

func _on_Timer_timeout():
	if IsNearPlayer:
		player.damageTaker.ResolveHit(dmgSrc)
	else:
		timer.stop()

func _on_DamageArea_body_exited(_body):
	IsNearPlayer = false
