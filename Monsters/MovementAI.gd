extends KinematicBody2D
class_name MovementAI
onready var fsm:FiniteStateMachine = $FiniteStateMachine
onready var _animated_sprite = $AnimatedSprite
export(PackedScene) var DamageEffect
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
func _ready():
	player = get_tree().get_nodes_in_group("PLAYER")[0]
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
	if abs(angle) > deg2rad(45) && abs(angle) < deg2rad(135):
		if movementDirection.y < 0:
			_animated_sprite.play("up_walk")
		elif movementDirection.y > 0:
			_animated_sprite.play("down_walk")
	else:
		if movementDirection.x > 0:
			_animated_sprite.play("right_walk")
		elif movementDirection.x < 0:
			_animated_sprite.play("left_walk")

func _physics_process(delta):
	fsm.Update(self, delta)

func _process(delta):
	fsm.ProcessEvent(self, self, delta)

func _on_Health_healthDepleted(parent):
	queue_free()

func _on_Health_damageTaken(currentHealth, maximumHealth):
	var damageEffect = DamageEffect.instance()
	get_parent().add_child(damageEffect)
	var tween = get_node("Tween")
	tween.interpolate_property($AnimatedSprite.material, "shader_param/blinkValue",
		1, 0, 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	damageEffect.transform = global_transform
