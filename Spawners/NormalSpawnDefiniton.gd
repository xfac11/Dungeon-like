extends SpawnDefinitons
class_name NormalSpawnDefiniton

signal spawn_coin(position, count)
signal spawn_exp(position, count)

export(int) var expCount = 1
export(int) var coinCount = 1
export(float, 0.0, 1.0) var coinChance = 1.0

func DiceRoll(chance):
	if chance <= 0 || chance >= 1:
		return bool(chance)
	return randf() < chance


func setup_Enemy(enemy, position):
	.setup_Enemy(enemy, position)


func enemy_died(enemy):
	emit_signal("spawn_exp", enemy.global_position, expCount)
	if DiceRoll(coinChance):
		emit_signal("spawn_coin", enemy.global_position, coinCount)
