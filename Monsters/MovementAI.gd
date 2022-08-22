extends KinematicBody2D

onready var _animated_sprite = $AnimatedSprite
export(PackedScene) var ExpOrb
export(PackedScene) var DamageEffect
var right = Vector2(1,0)
var left = Vector2(-1,0)
var up = Vector2(0,-1)
var down =  Vector2(0,1)
var velocity = Vector2(0,0)
export var speed = 50
var player:Node2D
func AddPlayer(var newPlayer):
	player = newPlayer

func _ready():
	GameHandler.connect("playerInitialized",self,"AddPlayer")
func _init():
	add_to_group("ENEMIES")

func _physics_process(delta):
	if player != null:
		var direction = player.position - position
		direction = direction.normalized()
		velocity = direction;
		move_and_slide(velocity.normalized()*speed) #move_and_slide uses delta internally so no need to *delta


func _process(_delta):
	if velocity.x > 0:
		_animated_sprite.play("right_walk")
	elif velocity.x < 0:
		_animated_sprite.play("left_walk")
	elif velocity.y < 0:
		_animated_sprite.play("down_walk")
	elif velocity.y > 0:
		_animated_sprite.play("up_walk")
	else:
		_animated_sprite.stop()
		
func SpawnExpOrb():
	var newOrb = ExpOrb.instance()
	owner.add_child(newOrb)
	newOrb.transform = global_transform


func _on_Health_healthDepleted():
	call_deferred("SpawnExpOrb")
	queue_free()

func _on_Health_damageTaken(currentHealth, maximumHealth):
	var damageEffect = DamageEffect.instance()
	owner.add_child(damageEffect)
	damageEffect.transform = global_transform
