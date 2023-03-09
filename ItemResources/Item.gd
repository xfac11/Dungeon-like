extends Resource
class_name Item

export var name:String
export var description:String
export var stackable : bool = false
export var maxStackSize: int = 1
export var frequency:int = 0
export var damage:int = 0
export var lifetime: int = 0
export var health:int = 0
export var armor:int = 0
export var speed:float = 0.0
export var projectileSpeed:float = 1.0
export var texture : Texture
export var projectilePS : PackedScene
export var itemStat : Resource
var directions = [Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0),Vector2(0.5,0.5),Vector2(-0.5,0.5),Vector2(0.5,-0.5),Vector2(-0.5,-0.5)]
const DamageTypeResource = preload("res://ItemResources/DamageType.gd")
export(DamageTypeResource.DamageType) var damageType
const ShootingTypeResource = preload("res://ItemResources/ShootingType.gd")
export(ShootingTypeResource.ShootingType) var shootingType
const ItemTypeResource = preload("res://ItemResources/ItemType.gd")
export(ItemTypeResource.ItemType) var itemType
