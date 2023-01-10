extends KinematicBody2D
class_name MovementAI
onready var fsm:FiniteStateMachine = $FiniteStateMachine
onready var sprite = $Sprite
export(PackedScene) var DamageEffect
export(PackedScene) var DeathEffect
export(NodePath) var startStatePath
onready var damageArea = $DamageArea
var right = Vector2(1,0)
var left = Vector2(-1,0)
var up = Vector2(0,-1)
var down =  Vector2(0,1)
var velocity = Vector2(0,0)
export var speed = 50
var player:Node2D
var expOrbCount = 1
var death = false
func _ready():
	##player = get_tree().get_nodes_in_group("PLAYER")[0]
	fsm.Initiate(get_node(startStatePath), self)

func _init():
	add_to_group("ENEMIES")

func IncreaseMaximumHealth(var percentIncrease:float):
	var health = get_node("Health")
	health.maximumHealth = health.maximumHealth*percentIncrease
	health.currentHealth = health.maximumHealth

func MoveTowardPlayer(speedMultiplier:float) -> bool:
	var direction:Vector2
	if is_instance_valid(player):
		direction = GetVectorToPlayer()
	else:
		return false
	direction = direction.normalized()
	velocity = direction;
	move_and_slide(velocity.normalized()*(speed*speedMultiplier))
	return true

func Move(direction:Vector2, speedMultiplier:float) -> void:
	direction = direction.normalized()
	velocity = direction;
	move_and_slide(velocity.normalized()*(speed*speedMultiplier))

func GetVectorToPlayer() -> Vector2:
	return player.position - position

func IsCloseToPlayer(var radius:float) -> bool:
	var toPlayer = GetVectorToPlayer()
	if toPlayer.length() < radius:
		return true
	return false
func UpdateAnimation(var movementDirection):
	var angle:float = movementDirection.angle()
func StopAnimation():
	pass
	#$AnimatedSprite.stop()
func _physics_process(delta):
	fsm.Update(self, delta)

func _process(delta):
	fsm.ProcessEvent(self, self, delta)

func _on_Health_healthDepleted(parent):
	death = true
	var tween = get_node("DeathTween")
	sprite.material.set_shader_param("hor_index", 0)
	var verIndex = 0.0
	#match $AnimatedSprite.animation:
	#	"down_walk":
	#		verIndex = 0
	#	"left_walk":
	#		verIndex = 1
	#	"right_walk":
	#		verIndex = 2
	#	"up_walk":
	#		verIndex = 3
	sprite.material.set_shader_param("ver_index", verIndex);
	tween.interpolate_property(sprite.material, "shader_param/noiseEffectivenes",
		0, 0.6, 0.8,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	tween.connect("tween_completed",self,"QueueSelf")
	SpawnObject(DeathEffect).emitting = true

func QueueSelf(object, key):
	queue_free()

func _on_Health_damageTaken(currentHealth, maximumHealth):
	var damageEffect = SpawnObject(DamageEffect)
	var tween = get_node("Tween")
	tween.interpolate_property(sprite.material, "shader_param/blinkValue",
		1, 0, 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()


func SpawnObject(packedScene):
	var object = packedScene.instance()
	get_parent().add_child(object)
	object.transform = global_transform
	return object
