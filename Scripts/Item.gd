extends Resource
class_name Item

export var name:String
export var stackable : bool = false
export var maxStackSize: int = 1
export var frequency:int = 0
export var damage:int = 0
export var lifetime: int = 0
export var health:int = 0
export var speed:float = 0.0
export var projectileSpeed:float = 1.0
export var texture : Texture
export var projectilePS : PackedScene
var directions = [Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0),Vector2(0.5,0.5),Vector2(-0.5,0.5),Vector2(0.5,-0.5),Vector2(-0.5,-0.5)]
enum DamageType{MELEE, RANGED, NONE}
export(DamageType) var damageType
enum ItemType{WEAPON, SHIELD, PASSIVE}
export(ItemType) var itemType
enum ShootingType{RANDOMDIR, RANDOMDIREACH, SPRAY, ROTATING, TOWARDENEMY}
export(ShootingType) var shootingType
export var effects:Script

func Use(nrOfStacks, owner, global_transform):
	var direction = directions[randi()%directions.size()]
	for n in nrOfStacks:
		var newBullet = projectilePS.instance()
		owner.add_child(newBullet)
		newBullet.transform = global_transform
		newBullet.damage = damage
		newBullet.SetDirection(direction)
		direction = direction.rotated(0.3)
