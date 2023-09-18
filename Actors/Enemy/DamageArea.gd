class_name DamageArea
extends Area2D

export var damage = 10
var player:Player
var is_near_player = false
var damage_source = DamageSource.new()

onready var timer = $Timer


func _ready():
	damage_source.physical = damage


func _on_DamageArea_body_entered(body:Player):
	player = body
	is_near_player = true
	timer.start()
	player.damage_taker.ResolveHit(damage_source)


func _on_Timer_timeout():
	if is_near_player:
		player.damage_taker.ResolveHit(damage_source)
	else:
		timer.stop()


func _on_DamageArea_body_exited(_body):
	is_near_player = false
