extends Resource
class_name Stat

export var damage:int = 0
export var speed:float = 0
export var health:int = 0
export var armor:int = 0
func GetStatsAsJSON() -> String:
	var statsStr:String = ""
	
	var itemStatDictionary = {
	"damage" : damage,
	"speed" : speed,
	"health" : health,
	"armor" : armor}
	
	statsStr += JSON.print(itemStatDictionary, "\t")
	
	return statsStr


func GetStatAsString() -> String:
	var statStr = ""
	statStr += "Damage: " + String(damage) + "\n"
	statStr += "Speed: " + String(speed) + "\n"
	statStr += "Health: " + String(health) + "\n"
	statStr += "Armor: " + String(armor) + "\n"
	return statStr
