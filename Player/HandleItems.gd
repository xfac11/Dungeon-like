class_name HandleItems
const ShootingTypeResource = preload("res://Items/ShootingType.gd")
var directions = [Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0),Vector2(0.5,0.5),Vector2(-0.5,0.5),Vector2(0.5,-0.5),Vector2(-0.5,-0.5)]
var bullets = {}
func Shoot(item:Item, nrOfStacks:int, owner, global_transform):
	match(item.shootingType):
		ShootingTypeResource.ShootingType.RANDOMDIR:
			ShootRandomDir(item, nrOfStacks, owner, global_transform)
		ShootingTypeResource.ShootingType.RANDOMDIREACH:
			ShootRandomDirEach(item, nrOfStacks, owner, global_transform)
		ShootingTypeResource.ShootingType.ROTATING:
			ShootRotating(item, nrOfStacks, owner, global_transform)
		ShootingTypeResource.ShootingType.SPRAY:
			ShootSpray(item, nrOfStacks, owner, global_transform)
		ShootingTypeResource.ShootingType.TOWARDENEMY:
			ShootTowardEnemy(item, nrOfStacks, owner, global_transform)
		
func ShootRandomDir(item:Item, nrOfStacks, owner, global_transform):
	var direction = directions[randi()% directions.size()]
	for n in nrOfStacks:
		var newBullet = item.projectilePS.instance()
		owner.add_child(newBullet)
		newBullet.transform = global_transform
		newBullet.damage = item.damage
		newBullet.SetDirection(direction)
		newBullet.theOwner = owner
		newBullet.globalTransform = global_transform
		direction = directions[randi()% directions.size()]

func ShootRandomDirEach(item:Item, nrOfStacks, owner, global_transform):
	var direction = directions[randi()% directions.size()]
	for n in nrOfStacks:
		var newBullet = item.projectilePS.instance()
		owner.add_child(newBullet)
		newBullet.transform = global_transform
		newBullet.damage = item.damage
		newBullet.speed = item.projectileSpeed
		newBullet.SetDirection(direction)
		direction = direction.rotated(0.3)

func ShootRotating(item:Item, nrOfStacks, owner, global_transform):
	if bullets.has(item):
		var itemBullets = bullets[item]
		print(itemBullets.size())
		for b in itemBullets.size():
			var bullet = itemBullets[b]
			if not is_instance_valid(bullet):
				itemBullets.remove(b)
				return
		if itemBullets.size() >= nrOfStacks*2:
			return
	var newBullet = item.projectilePS.instance()
	if bullets.has(item):
		bullets[item].append(newBullet)
	else:
		bullets[item] = []
		bullets[item].append(newBullet)
	owner.add_child(newBullet)
	newBullet.transform = global_transform
	newBullet.damage = item.damage * nrOfStacks
	newBullet.speed = item.projectileSpeed
	newBullet.SetDirection(Vector2(0,-1))
	

func ShootSpray(item:Item, nrOfStacks, owner, global_transform):
	var direction = directions[randi()% directions.size()]
	for n in 5:
		var newBullet = item.projectilePS.instance()
		owner.add_child(newBullet)
		newBullet.transform = global_transform
		newBullet.damage = item.damage * nrOfStacks
		newBullet.speed = item.projectileSpeed
		newBullet.lifeTime = item.lifetime
		newBullet.SetDirection(direction)
		newBullet.position += Vector2(5*sin(randf()),5*sin(randf()))
		direction = direction.rotated(0.05)


func ShootTowardEnemy(item, nrOfStacks, owner, global_transform):
	var enemies = owner.get_tree().get_nodes_in_group("ENEMIES")
	var distance:float = 100.0
	var playerPos:Vector2 = owner.get_tree().get_nodes_in_group("PLAYER")[0].position
	var nearestEnemy
	for enemy in enemies:
		var enemyToPlayer:Vector2 = playerPos - enemy.position
		var length = enemyToPlayer.length()
		if length < distance:
			distance = length
			nearestEnemy = enemy
	
	if enemies.size() == 0 or nearestEnemy == null:
		return
	var direction:Vector2 = nearestEnemy.position - playerPos
	direction = direction.normalized()
	var newBullet = item.projectilePS.instance()
	owner.add_child(newBullet)
	newBullet.transform = global_transform * newBullet.transform
	newBullet.damage = item.damage * nrOfStacks
	newBullet.speed = item.projectileSpeed
	newBullet.SetDirection(direction)
	
