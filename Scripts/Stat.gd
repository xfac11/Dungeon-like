extends Resource
class_name Stat

export var damage:int = 0
export var speed:float = 0
export var health:int = 0
export var armor:int = 0
export var healthRegen:int = 0
export(float, 0.0, 1.0) var criticalChance:float = 0
export(float, 0.0, 10.0) var criticalDamage:float = 0
export(float, 0.0, 1.0) var dodgeChance:float = 0
func GetStatsAsJSON() -> String:
	var statsStr:String = ""
	
	var itemStatDictionary = {
	"damage" : damage,
	"speed" : speed,
	"health" : health,
	"armor" : armor,
	"healthRegen" : healthRegen,
	"criticalChance" : criticalChance,
	"criticalDamage" : criticalDamage,
	"dodgeChance" : dodgeChance}
	
	statsStr += JSON.print(itemStatDictionary, "\t")
	
	return statsStr


func GetStatAsString() -> String:
	var statStr = ""
	statStr += "Damage: " + String(damage) + "\n"
	statStr += "Speed: " + String(speed) + "\n"
	statStr += "Health: " + String(health) + "\n"
	statStr += "Armor: " + String(armor) + "\n"
	statStr += "HP Regen: " + String(healthRegen) + "\n"
	statStr += "Crit chance: " + String(criticalChance) + "\n"
	statStr += "Crit dmg: " + String(criticalDamage) + "\n"
	statStr += "Dodge chance: " + String(dodgeChance) + "\n"
	return statStr


func get_stat_as_dictionary() -> Dictionary:
	var itemStatDictionary = {
	"Damage" : damage,
	"Speed" : speed,
	"Health" : health,
	"Armor" : armor,
	"HP regen" : healthRegen,
	"Crit chance" : criticalChance,
	"Crit dmg" : criticalDamage,
	"Dodge chance" : dodgeChance}
	return itemStatDictionary


func AddStat(stat:Stat, stack:int = 1):
	damage += stat.damage * stack
	speed += stat.speed * stack
	health += stat.health * stack
	armor += stat.armor * stack
	healthRegen += stat.healthRegen * stack
	criticalChance += stat.criticalChance * stack
	criticalDamage += stat.criticalDamage * stack
	dodgeChance += stat.dodgeChance * stack
