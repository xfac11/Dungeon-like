#Enemy class connects signals and sets variables 
#	to setup the systems to work with eachother and correctly
class_name Enemy
extends KinematicBody2D



onready var damage_taker:DamageTaker = $DamageTaker
onready var health:Health = $Health
onready var movement:Movement = $Movement
onready var state_machine:FiniteStateMachine = $FiniteStateMachine
onready var start_state = $FiniteStateMachine/ChasePlayer
onready var sprite = $Sprite


func _ready():
	$FiniteStateMachine/ChasePlayer.connect_health(health)
	$DeathEffect/Tween.connect("tween_completed", self, "queue_self")
	state_machine.initiate(start_state, self)


func _physics_process(delta):
	state_machine.update(self, delta)


func _process(delta):
	state_machine.process_event(self, self, delta)


func queue_self(_object, _key):
	queue_free()


func set_player(player:Player):
	$FiniteStateMachine/ChasePlayer.set_player(player)
	$FiniteStateMachine/Staggered.set_player(player)
