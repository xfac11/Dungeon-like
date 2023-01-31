extends Area2D

onready var timer = $Timer
onready var animation = $SwingAnimation
onready var line2D = $Node/Line2D
var swordStatResource = load("res://Stats/SwordStat.tres")
var baseStat:Stat = swordStatResource
var currentStat:Stat = Stat.new()
var dmgSrc = DamageSource.new()
var switchAnim = 0
func _ready() -> void:
	SetBaseStat()

func SetBaseStat() -> void:
	currentStat.health = baseStat.health
	currentStat.damage = baseStat.damage
	currentStat.speed = baseStat.speed
	
	currentStat.health += GameHandler.shopSwordStat.health
	currentStat.damage += GameHandler.shopSwordStat.damage
	currentStat.speed += GameHandler.shopSwordStat.speed
	
	dmgSrc.physical = currentStat.damage
	timer.wait_time = 1.0/currentStat.speed
	

func _on_Timer_timeout() -> void:
	if animation.is_playing():
		return
	if switchAnim == 1:
		animation.play("SwingAnimation")
		switchAnim = 0
	else:
		animation.play("SwingAnimation2")
		switchAnim = 1

func _on_MeleeWeapon_body_entered(body) -> void:
	var health = body.damageTaker
	if health:
		health.ResolveHit(dmgSrc)

func AddLine():
	var pos = $CPUParticles2D.global_position
	line2D.add_point(pos)
func ClearLines():
	line2D.clear_points()
