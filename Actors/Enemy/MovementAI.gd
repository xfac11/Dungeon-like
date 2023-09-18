class_name MovementAI
extends KinematicBody2D

export(NodePath) var start_state_path
export var speed:float = 50.0
var slowed_speed = 0.25
var player:Node2D
var death = false
var _normal_speed = 0.0

onready var fsm:FiniteStateMachine = $FiniteStateMachine
onready var sprite = $Sprite
onready var damage_area = $DamageArea
onready var health:Health = $DamageTaker/Health
onready var damage_taker = $DamageTaker
onready var damage_tween = $DamageTween
onready var death_tween = $DeathTween
onready var bleed_particles = $BleedParticles
onready var poison_particles = $PoisonParticles
onready var fire_particles = $FireParticles
onready var parent = get_parent()


func _ready():
	fsm.initiate(get_node(start_state_path), self)


func _physics_process(delta):
	fsm.update(self, delta)


func _process(delta):
	fsm.process_event(self, self, delta)


func increase_maximum_health(var percent_increase:float):
	health.maximumHealth = health.maximumHealth*percent_increase
	health.currentHealth = health.maximumHealth


func move_toward_player(speed_multiplier:float) -> bool:
	var direction = _get_vector_to_player()
	if is_instance_valid(player):
		var _velocity = move_and_slide(direction.normalized()*(speed*speed_multiplier))
		return true
	return false


func move(direction:Vector2, speed_multiplier:float) -> void:
	var _velocity = move_and_slide(direction.normalized()*(speed*speed_multiplier))


func _on_Health_healthDepleted(_parent):
	death = true
	death_tween.interpolate_property(sprite.material, "shader_param/noiseEffectivenes",
		0, 0.6, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	death_tween.start()
	death_tween.connect("tween_completed",self,"_queue_self")


func _queue_self(_object, _key):
	queue_free()


func _on_Health_damageTaken(_currentHealth, _maximumHealth, _damageAmount):
	damage_tween.interpolate_property(sprite.material, "shader_param/blinkValue",
		1, 0, 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	damage_tween.start()


func _on_DamageTaker_bleedStarted():
	bleed_particles.emitting = true


func _on_DoTBleed_timeout():
	bleed_particles.emitting = false


func _on_DoTPoison_timeout():
	poison_particles.emitting = false


func _on_DamageTaker_fireStarted():
	fire_particles.emitting = true


func _on_DamageTaker_poisonStarted():
	poison_particles.emitting = true


func _on_DoTFire_timeout():
	fire_particles.emitting = false


func _on_DamageTaker_OnSlowed():
	_normal_speed = speed
	speed = slowed_speed * speed
	sprite.modulate = Color.blue


func _on_DamageTaker_OnSlowedStop():
	speed = _normal_speed
	sprite.modulate = Color.white


func _get_vector_to_player() -> Vector2:
	return player.position - position
