extends KinematicBody2D
class_name MovementAI
onready var fsm:FiniteStateMachine = $FiniteStateMachine
onready var sprite = $Sprite
onready var damageArea = $DamageArea
onready var health:Health = $DamageTaker/Health
onready var damageTaker = $DamageTaker
onready var damage_tween = $Tween
onready var death_tween = $DeathTween
onready var bleedParticles = $BleedParticles
onready var poisonParticles = $PoisonParticles
onready var firePartcles = $FireParticles
onready var parent = get_parent()
export(PackedScene) var DeathEffect
export(NodePath) var startStatePath
var right = Vector2(1,0)
var left = Vector2(-1,0)
var up = Vector2(0,-1)
var down =  Vector2(0,1)
var velocity:Vector2 = Vector2(0,0)
export var speed:float = 50.0
var slowedSpeed = 0.25
var normalSpeed
var player:Node2D
var expOrbCount = 1
var death = false
func _ready():
	fsm.Initiate(get_node(startStatePath), self)


func IncreaseMaximumHealth(var percentIncrease:float):
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


func _physics_process(delta):
	fsm.Update(self, delta)


func _process(delta):
	fsm.ProcessEvent(self, self, delta)


func _on_Health_healthDepleted(parent):
	death = true
	#sprite.material.set_shader_param("hor_index", 0)
	var verIndex = 0.0
	#sprite.material.set_shader_param("ver_index", verIndex);
	death_tween.interpolate_property(sprite.material, "shader_param/noiseEffectivenes",
		0, 0.6, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	death_tween.start()
	death_tween.connect("tween_completed",self,"QueueSelf")
	#SpawnObject(DeathEffect).emitting = true


func QueueSelf(object, key):
	queue_free()


func _on_Health_damageTaken(currentHealth, maximumHealth, damageAmount):
	damage_tween.interpolate_property(sprite.material, "shader_param/blinkValue",
		1, 0, 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	damage_tween.start()


func SpawnObject(packedScene):
	var object = packedScene.instance()
	parent.call_deferred("add_child", object)
	object.transform = global_transform
	return object

func _on_DamageTaker_bleedStarted():
	bleedParticles.emitting = true


func _on_DoTBleed_timeout():
	bleedParticles.emitting = false


func _on_DoTPoison_timeout():
	poisonParticles.emitting = false


func _on_DamageTaker_fireStarted():
	firePartcles.emitting = true


func _on_DamageTaker_poisonStarted():
	poisonParticles.emitting = true


func _on_DoTFire_timeout():
	firePartcles.emitting = false


func _on_DamageTaker_OnSlowed():
	normalSpeed = speed
	speed = slowedSpeed * speed
	sprite.modulate = Color.blue

func _on_DamageTaker_OnSlowedStop():
	speed = normalSpeed
	sprite.modulate = Color.white
