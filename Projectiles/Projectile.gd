extends Node2D
class_name Projectile

export(float) var speed:float = 100.0
export(float) var lifeTime:float = 10.0
export(int) var damage:int = 10
export var damageSrc:Resource
var forward:Vector2 = Vector2(0,-1)
var currentTime = 0
var theOwner setget set_theOwner
var globalTransform
var direction
func _process(delta):
	CalcTime(delta)
func _physics_process(delta):
	Movement(delta)
func SetDirection(var newDirection:Vector2):
	direction = newDirection
	var angle = direction.normalized().angle_to(forward)
	rotation = -angle

func CalcTime(delta):
	currentTime += delta
	if currentTime >= lifeTime:
		LifetimeEnd()
		currentTime = 0

func LifetimeEnd():
	queue_free()

func set_theOwner(obj):
	theOwner = obj

func HitBody(body):
	body.damage_taker.ResolveHit(damageSrc)
	queue_free()
	
func Movement(delta):
	position += delta*speed*direction.normalized()
	
	var angle = direction.normalized().angle_to(forward)
	rotation = -angle

func _on_Projectile_body_entered(body):
	HitBody(body)
