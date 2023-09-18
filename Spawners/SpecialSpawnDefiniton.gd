extends SpawnDefinitons
class_name SpecialSpawnDefiniton

signal spawn_chest(position)
signal spawn_exp(position, count)
export(float, 1.0, 3.0) var damageScale = 1.0
export(float, 1.0, 3.0) var speedScale = 1.0
export(float, 1.0, 3.0) var maxHealthScale = 1.0
export(float, 1.0, 3.0) var size = 1.0
export(int) var expCount = 1.0
export(Color) var outlineColor = Color.blue

func setup_Enemy(enemy, position):
	.setup_Enemy(enemy, position)
	enemy.scale = Vector2(size, size)
	enemy.damage_area.damage*= damageScale
	enemy.movement.speed*= speedScale
	enemy.health.increase_maximum_health(maxHealthScale)
	var enemyMat:ShaderMaterial = enemy.sprite.material
	enemyMat.set_shader_param("edgeShading", true)
	enemyMat.set_shader_param("edgeColor", outlineColor)

func enemy_died(enemy):
	emit_signal("spawn_chest", enemy.position)
	emit_signal("spawn_exp", enemy.position, expCount)
