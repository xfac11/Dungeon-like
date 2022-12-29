extends Node2D
class_name EnemyPack
onready var enemies = get_children()
var damage setget SetDamage, GetDamage

func SetDamage(new_value):
	damage = new_value
	for enemy in enemies:
		enemy.damageArea.damage = damage

func GetDamage():
	return  enemies[0].damageArea.damage# Getter must return a value.
