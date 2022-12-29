extends Resource
class_name Stat

export var damage:int = 0
export var speed:float = 0
export var health:int = 0

func GetStatsAsJSON() -> String:
	var statsStr:String = ""
	
	var itemStatDictionary = {
	"damage" : damage,
	"speed" : speed,
	"health" : health}
	
	statsStr += JSON.print(itemStatDictionary, "\t")
	
	return statsStr
