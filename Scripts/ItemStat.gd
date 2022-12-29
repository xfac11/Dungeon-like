extends Stat
class_name ItemStat
export var stackable : bool = false
export var maxStackSize: int = 1
export var frequency:int = 0
export var lifetime: int = 0
export var projectileSpeed:float = 1.0
const DamageTypeResource = preload("res://DamageType.gd")
export(DamageTypeResource.DamageType) var damageType
const ShootingTypeResource = preload("res://ShootingType.gd")
export(ShootingTypeResource.ShootingType) var shootingType
const ItemTypeResource = preload("res://ItemType.gd")
export(ItemTypeResource.ItemType) var itemType
func GetStatsAsJSON() -> String:
	var baseStats:String = .GetStatsAsString()
	var statsStr:String
	
	var itemStatDictionary = {
	"stackable" : stackable, 
	"maxStackSize" : maxStackSize,
	"frequency" : frequency,
	"lifetime" : lifetime,
	"projectileSpeed" : projectileSpeed,
	"damageType" : damageType,
	"itemType" : itemType,
	"shootingType" : shootingType}
	
	statsStr += baseStats
	statsStr += JSON.print(itemStatDictionary, "\t")
	
	return statsStr
