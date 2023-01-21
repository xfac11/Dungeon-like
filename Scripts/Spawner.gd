tool
extends Node2D
const MAXIMUMENEMIES = 100
var currentEnemies = 0
onready var spawnTimer = $SpawnTimer
onready var waveTimer = $WaveTimer
onready var enemyDefs = $Enemies.get_children()
export(PackedScene)var SpawnParticlesScene
export var mRadius = 5
export var mWidth = 10
export var mHeight = 10
export(float, 0.0, 1.0) var decreaseSpawnTime = 0.9
var secondsBetweenWaves = 30
var secondsBetweenSpawn = 1
var currentSecondsBetweenSpawn = 0
export var pathToRoot:NodePath
var wave = 1
var randomGen:RandomGen = RandomGen.new()
signal NewWave(waveNumber)

func _ready():
	randomize()
	secondsBetweenSpawn = spawnTimer.wait_time
	secondsBetweenWaves = waveTimer.wait_time
	currentSecondsBetweenSpawn = secondsBetweenSpawn


func _on_Timer_timeout():
	if currentEnemies >= MAXIMUMENEMIES:
		return
	for enemySpawnDef in enemyDefs:
		if !DiceRoll(enemySpawnDef.chance):
			continue
		var randomPosition = randomGen.RandomRectangle(mHeight, mWidth) + global_position
		spawn_particles(randomPosition)
		get_tree().create_timer(1.0).connect("timeout", self, "_create_enemy", [enemySpawnDef, randomPosition])
		break

func _create_enemy(enemyDefinition:SpawnDefinitons, enemyPosition:Vector2):
	var enemy = SpawnObject(enemyDefinition.enemy_scene)
	enemyDefinition.setup_Enemy(enemy, enemyPosition)
	var health = enemy.get_node("Health")
	health.connect("healthDepleted", self, "DecreaseCurrentEnemies")
	health.connect("healthDepleted", enemyDefinition, "enemy_died")
	currentEnemies+= 1

func spawn_particles(randomPosition):
	var spawnParticles = SpawnObject(SpawnParticlesScene)
	spawnParticles.position = randomPosition
	spawnParticles.emitting = true


func SpawnObject(packedScene):
	var object = packedScene.instance()
	get_parent().add_child(object)
	object.transform = get_parent().transform
	return object


func DiceRoll(chance):
	if chance <= 0 || chance >= 1:
		return bool(chance)
	return randf() < chance

func DecreaseCurrentEnemies(_parent):
	currentEnemies-= 1


func _on_WaveTimer_timeout():
	wave += 1
	emit_signal("NewWave",wave)
	currentSecondsBetweenSpawn = currentSecondsBetweenSpawn * decreaseSpawnTime
	spawnTimer.wait_time = currentSecondsBetweenSpawn
	spawnTimer.start()

# Editor drawing
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
		var width = mWidth
		var height = mHeight
		var color = Color(1.0, 0.0, 0.0, 0.5)
		drawRect(center, width, height, color)


func _process(_delta):
	if Engine.editor_hint:
		update()
