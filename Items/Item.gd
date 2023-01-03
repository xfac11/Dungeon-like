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
var directions = [Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0),Vector2(0.5,0.5),Vector2(-0.5,0.5),Vector2(0.5,-0.5),Vector2(-0.5,-0.5)]
const DamageTypeResource = preload("res://Items/DamageType.gd")
export(DamageTypeResource.DamageType) var damageType
const ShootingTypeResource = preload("res://Items/ShootingType.gd")
export(ShootingTypeResource.ShootingType) var shootingType
const ItemTypeResource = preload("res://Items/ItemType.gd")
export(ItemTypeResource.ItemType) var itemType
func Use(nrOfStacks:int, owner, global_transform:Transform):
	var direction:Vector2 = directions[randi()%directions.size()]
	for n in nrOfStacks:
		var newBullet:Projectile = projectilePS.instance()
		owner.add_child(newBullet)
		newBullet.transform = global_transform
		newBullet.damage = damage
		newBullet.SetDirection(direction)
		direction = direction.rotated(0.3)
