class_name HandleItems
const ShootingTypeResource = preload("res://ItemResources/ShootingType.gd")
var directions = [Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0),Vector2(0.5,0.5),Vector2(-0.5,0.5),Vector2(0.5,-0.5),Vector2(-0.5,-0.5)]
var bullets = {}
func Shoot(item:Item, nrOfStacks:int, owner, global_transform):
	match(item.itemStat.shootingType):
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
		ShootingTypeResource.ShootingType.ONPLAYER:
			ShootOnPlayer(item, nrOfStacks, owner, global_transform)
		
func ShootRandomDir(item:Item, nrOfStacks, owner, global_transform):
	var player = owner.get_tree().get_nodes_in_group("PLAYER")[0]
	var direction = directions[randi()% directions.size()]
	for n in nrOfStacks:
		var newBullet = item.projectilePS.instance()
		owner.add_child(newBullet)
		newBullet.transform = global_transform
		newBullet.damageSrc = create_damage_source(newBullet, item, player, nrOfStacks)
		newBullet.SetDirection(direction)
		newBullet.theOwner = owner
		newBullet.globalTransform = global_transform
		direction = directions[randi()% directions.size()]

func ShootRandomDirEach(item:Item, nrOfStacks, owner, global_transform):
	var player = owner.get_tree().get_nodes_in_group("PLAYER")[0]
	var direction = directions[randi()% directions.size()]
	for n in nrOfStacks:
		var newBullet = item.projectilePS.instance()
		owner.add_child(newBullet)
		newBullet.theOwner = owner
		newBullet.transform = global_transform
		newBullet.damageSrc = create_damage_source(newBullet, item, player, nrOfStacks)
		newBullet.speed = item.itemStat.projectileSpeed
		newBullet.SetDirection(direction)
		direction = direction.rotated(0.3)

func ShootRotating(item:Item, nrOfStacks, owner, global_transform):
	var player = owner.get_tree().get_nodes_in_group("PLAYER")[0]
	if bullets.has(item):
		var itemBullets = bullets[item]
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
	newBullet.transform = global_transform
	newBullet.damageSrc = create_damage_source(newBullet, item, player, nrOfStacks)
	newBullet.speed = item.itemStat.projectileSpeed
	newBullet.theOwner = owner
	owner.add_child(newBullet)
	newBullet.SetDirection(Vector2(0,-1))
	

func ShootSpray(item:Item, nrOfStacks, owner, global_transform):
	var direction = directions[randi()% directions.size()]
	var player = owner.get_tree().get_nodes_in_group("PLAYER")[0]
	for n in 2*nrOfStacks:
		var newBullet = item.projectilePS.instance()
		newBullet.transform = global_transform
		newBullet.damageSrc = create_damage_source(newBullet, item, player, nrOfStacks)
		newBullet.speed = item.itemStat.projectileSpeed
		newBullet.lifeTime = item.itemStat.lifetime
		newBullet.theOwner = owner
		newBullet.SetDirection(direction)
		var randomF = randf()
		newBullet.position += Vector2(5.0*sin(randomF),5.0*cos(randomF))
		direction = direction.rotated(0.1)
		owner.add_child(newBullet)


func ShootTowardEnemy(item, nrOfStacks, owner, global_transform):
	var enemies = owner.get_tree().get_nodes_in_group("ENEMIES")
	var distance:float = 100.0
	var player = owner.get_tree().get_nodes_in_group("PLAYER")[0]
	var playerPos:Vector2 = player.position
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
	
	newBullet.damageSrc = create_damage_source(newBullet, item, player, nrOfStacks)
	newBullet.speed = item.itemStat.projectileSpeed
	newBullet.theOwner = owner
	newBullet.SetDirection(direction)


func ShootOnPlayer(item, nrOfStacks, owner, global_transform):
	var player = owner.get_tree().get_nodes_in_group("PLAYER")[0]
	if bullets.has(item):
		bullets[item].damageSrc = create_damage_source(bullets[item], item, player, nrOfStacks)
		bullets[item].size = nrOfStacks
		return
	var newBullet = item.projectilePS.instance()
	owner.add_child(newBullet)
	newBullet.theOwner = owner
	newBullet.transform = global_transform
	newBullet.damageSrc = create_damage_source(newBullet, item, player, nrOfStacks)
	newBullet.speed = 0.0
	newBullet.SetDirection(Vector2(0, 0))
	bullets[item] = newBullet
	


func create_damage_source(newBullet, item, player, nrOfStacks):
	var dmgSource = DamageSource.new()
	dmgSource.physical = clamp(newBullet.damageSrc.physical, 0.0, 1.0) * ((item.itemStat.damage * nrOfStacks) + player.currentStat.damage)
	dmgSource.fire = clamp(newBullet.damageSrc.fire, 0.0, 1.0) *  ((item.itemStat.damage * nrOfStacks) + player.currentStat.damage)
	dmgSource.cold = clamp(newBullet.damageSrc.cold, 0.0, 1.0) *  ((item.itemStat.damage * nrOfStacks) + player.currentStat.damage)
	dmgSource.criticalChance = item.itemStat.criticalChance + player.currentStat.criticalChance
	dmgSource.criticalDamage = item.itemStat.criticalDamage + player.currentStat.criticalDamage
	dmgSource.poisonChance = newBullet.damageSrc.poisonChance
	dmgSource.item = item
	return dmgSource
