class_name SpawnDefinitons
extends Node

signal spawn_text2D(damage, isCrit, parent, damageSrc)

export(float, 0.0, 1.0) var chance = 1.0
export(PackedScene) var enemy_scene

func enemy_died(enemy):
	pass


func enemy_spawned():
	pass


func enemy_damaged(damage, isCrit, parent, damageSrc):
	emit_signal("spawn_text2D", damage, isCrit, parent, damageSrc)


func setup_Enemy(enemy, position):
	enemy.position = position
	enemy.set_player(get_tree().get_nodes_in_group("PLAYER")[0])

