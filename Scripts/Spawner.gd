tool
extends Node2D
const MAXIMUMENEMIES = 100
var currentEnemies = 0
onready var spawnTimer = $SpawnTimer
onready var waveTimer = $WaveTimer
export(PackedScene)var enemyToSpawn
export(PackedScene)var enemyPack
export(PackedScene)var coinPS
export(PackedScene)var chestPS
export(PackedScene)var ExpOrb
export(PackedScene)var ExpOrb5
export var specialEnemyChance = 0.1
export var packChance = 0.01
export var mRadius = 5
export var mWidth = 10
export var mHeight = 10
export var coinDropChance = 0.1
export var decreaseSpawnTime = 0.9
export var secondsBetweenWaves = 30
export var secondsBetweenSpawn = 1
var currentSecondsBetweenSpawn = 0
export var pathToRoot:NodePath
var wave = 1
var direction:Array = [Vector2(1,0),Vector2(0,1),Vector2(-1,0),Vector2(0,-1)]
var randomGen:RandomGen = RandomGen.new()
signal NewWave(waveNumber)
func _ready():
	randomize()
	secondsBetweenSpawn = spawnTimer.wait_time
	secondsBetweenWaves = waveTimer.wait_time
	currentSecondsBetweenSpawn = secondsBetweenSpawn
func _on_Timer_timeout():
#	if get_node(pathToRoot).maximumEnemies <= get_tree().get_nodes_in_group("ENEMIES").size():
#		return
	if currentEnemies >= MAXIMUMENEMIES:
		return
	if DiceRoll(specialEnemyChance):
		var _unused = SpawnEnemySpecial(1.3,1.2)
		currentEnemies+= 1
	elif DiceRoll(packChance):
		SpawnEnemyPack(10,1)
		currentEnemies+= 10
	else:
		var enemy = SpawnEnemy(1, 1)
		var healthEnemy:Health = enemy.get_node("Health")
		healthEnemy.connect("healthDepleted",self,"DefferedSpawnCoin")
		healthEnemy.connect("healthDepleted",self,"DefferedSpawnExpOrb")
		currentEnemies+= 1

func SpawnEnemy(speed,damage):
	var newEnemy = enemyToSpawn.instance()
	get_node(pathToRoot).add_child(newEnemy)
	newEnemy.position = randomGen.RandomRectangle(mWidth,mHeight) + global_position
	newEnemy.speed = newEnemy.speed * speed
	newEnemy.damageArea.damage = newEnemy.damageArea.damage * damage
	var healthEnemy:Health = newEnemy.get_node("Health")
	healthEnemy.connect("healthDepleted",self,"DecreaseCurrentEnemies")
	return newEnemy
	
func DiceRoll(chance):
	return randf() < chance

func DefferedSpawnCoin(parent):
	call_deferred("SpawnCoin", parent)

func SpawnCoin(parent):
	if DiceRoll(coinDropChance):
		var newCoin = coinPS.instance()
		get_node(pathToRoot).add_child(newCoin)
		newCoin.position = parent.global_position

func DefferedSpawnExpOrb(parent):
	call_deferred("SpawnExpOrb", parent, ExpOrb)
func DefferedSpawnExpOrb5(parent):
	call_deferred("SpawnExpOrb", parent, ExpOrb5)
func SpawnExpOrb(parent, expOrbType:PackedScene):
	var newOrb = expOrbType.instance()
	get_parent().add_child(newOrb)
	newOrb.transform = parent.global_transform
	newOrb.position+= Vector2(randf(),randf())*5

func SpawnChest(parent):
	var newOrb:Chest = chestPS.instance()
	get_parent().add_child(newOrb)
	newOrb.transform = parent.global_transform
	newOrb.position+= Vector2(randf(),randf())*5
	newOrb.connect("ChestPickedUp",self,"RollChestUI")
func RollChestUI():
	var count = 1
	if DiceRoll(0.3):
		count = 3
	if DiceRoll(0.1):
		count = 5
	var itemsToAdd = RandomItemsFromInventory(count)
	var player:Player = get_tree().get_nodes_in_group("PLAYER")[0]
	var inventory:Inventory = player.inventory
	var possibleItems = inventory.items
	inventory.AddItems(itemsToAdd)
	ShowChestUI(itemsToAdd, possibleItems)

func ShowChestUI(itemsToAdd, possibleItems):
	pass

func RandomItemsFromInventory(count):
	var player:Player = get_tree().get_nodes_in_group("PLAYER")[0]
	var itemsInInventory = player.inventory.GetItems()
	if itemsInInventory.size() == 0:
		return
	var itemsToAdd = Array()
	for i in count:
		var randomIndex = randi() % itemsInInventory.size()
		var inventory:Inventory = player.inventory
		var itemName = itemsInInventory[randomIndex].item.name
		itemsToAdd.append(itemName)
	return itemsToAdd
func DefferedSpawnChest(parent):
	call_deferred("SpawnChest", parent)

func SpawnEnemySpecial(speed, damage):
	var newEnemy:MovementAI = SpawnEnemy(speed,damage)
	newEnemy.scale = newEnemy.scale * 1.1
	newEnemy.IncreaseMaximumHealth(3)
	var healthEnemy:Health = newEnemy.get_node("Health")
	healthEnemy.connect("healthDepleted",self,"DefferedSpawnChest")
	healthEnemy.connect("healthDepleted",self,"DefferedSpawnExpOrb5")
	var enemyMat:ShaderMaterial = newEnemy.get_node("AnimatedSprite").material
	enemyMat.set_shader_param("edgeShading", true)
	return newEnemy
	
func SpawnEnemyPack(speed, damage):
	var enemies = Array()
	for i in 10:
		enemies.push_back(enemyPack.instance())
		get_node(pathToRoot).add_child(enemies.back())
	var packPosition = randomGen.RandomCircleInRect(mWidth, mHeight, mRadius)
	var direction = get_tree().get_nodes_in_group("PLAYER")[0].position - (packPosition + global_position)
	for enemy in enemies:
		var enemyPosition = randomGen.RandomCircle(mRadius, packPosition) + global_position
		enemy.position = enemyPosition
		enemy.speed = enemy.speed * speed
		enemy.damageArea.damage = enemy.damageArea.damage * damage
		enemy.fsm.get_node("WalkTowards").direction = direction.normalized()
		var healthEnemy:Health = enemy.get_node("Health")
		healthEnemy.connect("healthDepleted",self,"DefferedSpawnCoin")
		healthEnemy.connect("healthDepleted",self,"DecreaseCurrentEnemies")
func DecreaseCurrentEnemies(parent):
	currentEnemies-= 1
func drawRect(pos, width, height, color):
	draw_rect(Rect2(pos,Vector2(width,height)),color)

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)

func _draw():
	if Engine.editor_hint:
		var center = Vector2(0, 0)
		var radius = mRadius
		var width = mWidth
		var height = mHeight
		var angle_from = 0
		var angle_to = 360
		var color = Color(1.0, 0.0, 0.0, 0.5)
		drawRect(center, width, height, color)
	
func _process(delta):
	if Engine.editor_hint:
		update()


func _on_WaveTimer_timeout():
	wave += 1
	emit_signal("NewWave",wave)
	currentSecondsBetweenSpawn = currentSecondsBetweenSpawn * decreaseSpawnTime
	spawnTimer.wait_time = currentSecondsBetweenSpawn
