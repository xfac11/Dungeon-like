extends Resource
class_name Item

export var name:String
export var description:String
export var texture : Texture
export var projectilePS : PackedScene
export var itemStat : Resource
var directions = [Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0),Vector2(0.5,0.5),Vector2(-0.5,0.5),Vector2(0.5,-0.5),Vector2(-0.5,-0.5)]
var health setget ,get_health
var speed setget ,get_speed
var armor setget ,get_armor
var damage setget ,get_damage
var itemType setget ,get_itemType

func get_health():
	return itemStat.health


func get_speed():
	return itemStat.speed


func get_armor():
	return itemStat.armor


func get_damage():
	return itemStat.damage


func get_itemType():
	return itemStat.itemType
