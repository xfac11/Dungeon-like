extends Node2D
class_name Projectile

export(float) var speed:float = 100.0
export(float) var lifeTime:float = 10.0
export(int) var damage:int = 10
onready var sprite = $Sprite
var forward:Vector2 = Vector2(0,-1)
var currentTime = 0
var theOwner
var globalTransform
onready var direction = Vector2(1,0).rotated(randf() * 2.0 * PI)
func _process(delta):
	CalcTime(delta)
func _physics_process(delta):
	Movement(delta)
func SetDirection(var newDirection:Vector2):
	direction = newDirection

func CalcTime(delta):
	currentTime += delta
	if currentTime >= lifeTime:
		LifetimeEnd()

func LifetimeEnd():
	queue_free()

func HitBody(body):
	body.get_node("Health").TakeDamage(damage)
	queue_free()
	
func Movement(delta):
	position += delta*speed*direction
	
	var angle = direction.normalized().angle_to(forward)
	rotation = -angle

func _on_Projectile_body_entered(body):
	HitBody(body)
