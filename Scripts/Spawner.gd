extends Node2D


export(PackedScene)var enemyToSpawn
export var specialEnemyChance = 100
var direction:Array = [Vector2(1,0),Vector2(0,1),Vector2(-1,0),Vector2(0,-1)]
var index = 0
func _on_Timer_timeout():
	if GameHandler.maximumEnemies <= get_tree().get_nodes_in_group("ENEMIES").size():
		return
	if randi()%specialEnemyChance == 1:
		SpawnEnemySpecial(1.3,1.2)
	else:
		SpawnEnemy(1, 1)
	index = index + 1
	if index >= direction.size():
		index = 0

func SpawnEnemy(speed,damage):
	var newEnemy = enemyToSpawn.instance()
	owner.add_child(newEnemy)
	#newEnemy.transform = global_transform * transform
	newEnemy.position = position
	newEnemy.speed = newEnemy.speed * speed
	newEnemy.damageArea.damage = newEnemy.damageArea.damage * damage
	newEnemy.position+= direction[index] * 2

func SpawnEnemySpecial(speed, damage):
	var newEnemy = enemyToSpawn.instance()
	owner.add_child(newEnemy)
	#newEnemy.transform = global_transform * transform
	newEnemy.position = position
	newEnemy.speed = newEnemy.speed * speed
	newEnemy.damageArea.damage = newEnemy.damageArea.damage * damage
	newEnemy.position+= direction[index] * 2
	newEnemy.scale = newEnemy.scale * 1.1
	newEnemy.modulate = Color.aqua
