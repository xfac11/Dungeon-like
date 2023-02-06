extends Node
class_name DamageTaker

signal bleedStarted()
signal poisonStarted()
signal fireStarted()
signal OnSlowed()
signal OnSlowedStop()
signal dodged()
signal blocked()
signal damageTaken(damage, isCrit, parent)

onready var dotFire:Timer = $DoTFire
onready var dotPoison:Timer = $DoTPoison
onready var dotBleed:Timer = $DoTBleed
onready var slowTimer:Timer = $Slow
onready var health:Health = $Health

const SLOWCHANCE:float = 0.25
const RESISTANCECAP:float = 0.75
const BLOCKCAP:float = 0.75
const DODGECAP:float = 0.75

const IGNITEMODIFIER:float = 0.5
const POISONMODIFIER:float = 0.1
const BLEEDMODIFIER:float = 0.25
const BLEEDSTACKCAP:int = 8
const POISONSTACKCAP:int = 8


export var armor:float = 0.0
export var block:float = 0.0
export var dodge:float = 0.0

export var fireResistance:float = 0.0
export var coldResistance:float = 0.0

var currentBleed = 0.0
var bleedDuration = 8
var bleedStacks = 0
var currentIgnite = 0.0
var igniteDuration = 4
var currentPoison = 0.0
var poisonDuration = 4
var poisonStacks = 0
var coldStacks = 0
func _ready():
	dotBleed.connect("timeout",self,"StopBleed")
	dotPoison.connect("timeout",self,"StopPoison")
	dotFire.connect("timeout",self,"StopIgnite")
	dotBleed.get_child(0).connect("timeout",self,"DoBleedDamage")
	dotPoison.get_child(0).connect("timeout",self,"DoPoisonDamage")
	dotFire.get_child(0).connect("timeout",self,"DoIgniteDamage")
func StopBleed():
	currentBleed = 0
	bleedStacks = 0
	dotBleed.get_child(0).stop()
func StopPoison():
	currentPoison = 0
	poisonStacks = 0
	dotPoison.get_child(0).stop()
func StopIgnite():
	currentIgnite = 0
	dotFire.get_child(0).stop()
func DoBleedDamage():
	health.TakeDotDamage(currentBleed * 0.1)
func DoPoisonDamage():
	health.TakeDotDamage(currentPoison * 0.1)
func DoIgniteDamage():
	health.TakeDotDamage(currentIgnite * 0.1)

func ResolveHit(damageSrc:DamageSource) -> void:
	var damage:float = 0.0
	if Roll(min(dodge, DODGECAP)):
		emit_signal("dodged")
		return
	if Roll(min(block, BLOCKCAP)):
		emit_signal("blocked")
		return##stun animation
	var crit = Roll(damageSrc.criticalChance)
	var critAsFloat = float(crit)
	if damageSrc.physical > 0.0:
		var physicalDamageReduction:float = PhysicalReduction(armor,damageSrc.physical)
		var physicalDamage = damageSrc.physical
		physicalDamage+= physicalDamage * critAsFloat * damageSrc.criticalDamage
		if Roll(damageSrc.poisonChance):
			ApplyPoison(physicalDamage)
		physicalDamage*= 1 - physicalDamageReduction
		damage += physicalDamage
		if Roll(damageSrc.bleedChance):
			ApplyBleed(physicalDamage)
			##apply bleed based on calculated damage and dot effectiveness
	if damageSrc.fire > 0.0:
		var fireDamageReduction:float = FireDamageReduction(fireResistance, damageSrc.fire)
		var fireDamage = damageSrc.fire
		fireDamage+= fireDamage * critAsFloat * damageSrc.criticalDamage
		fireDamage*= (1 - fireDamageReduction)
		damage += fireDamage
		if Roll(damageSrc.igniteChance):
			ApplyIgnite(fireDamage)
	if damageSrc.cold > 0.0:
		var coldDamageReduction:float = ColdDamageReduction(coldResistance, damageSrc.cold)
		var coldDamage = damageSrc.cold
		coldDamage+= coldDamage * critAsFloat * damageSrc.criticalDamage
		coldDamage*= (1 - coldDamageReduction)
		if Roll(SLOWCHANCE * critAsFloat):
			if slowTimer.is_stopped():
				Slow()
		damage+= coldDamage
	emit_signal("damageTaken", damage, crit, get_parent())
	health.TakeDamage(damage)
func Slow():
	slowTimer.start()
	emit_signal("OnSlowed")
func PhysicalReduction(armor:float, physicalDamage:float) -> float:
	return armor / (armor + 5.0 * physicalDamage)
func ColdDamageReduction(coldResistance, coldDamage) -> float:
	return min(RESISTANCECAP, coldResistance)
func FireDamageReduction(fireResistance:float, fireDamage:float) -> float:
	return min(RESISTANCECAP, fireResistance)

func Roll(chance:float) -> bool:
	return chance != 0 && randf() <= chance

func ApplyBleed(physicalDamage:float) -> void:
	bleedStacks = min(BLEEDSTACKCAP, bleedStacks + 1)
	var bleedDamage = BleedDamage(physicalDamage, bleedStacks)
	if currentBleed < bleedDamage:
		currentBleed = bleedDamage
	dotBleed.start()
	emit_signal("bleedStarted")
	dotBleed.get_child(0).start()

func ApplyIgnite(fireDamage:float) -> void:
	var igniteDamage = IgniteDamage(fireDamage)
	if currentIgnite < igniteDamage:
		currentIgnite = igniteDamage
	dotFire.start()
	emit_signal("fireStarted")
	dotFire.get_child(0).start()
func ApplyPoison(physicalDamage:float) -> void:
	poisonStacks = min(POISONSTACKCAP, poisonStacks + 1)
	var poisonDamage = PoisonDamage(physicalDamage, poisonStacks)
	currentPoison += poisonDamage
	dotPoison.start()
	emit_signal("poisonStarted")
	dotPoison.get_child(0).start()
func BleedDamage(physicalDamage:float, bleedStacks:int) -> float:
	return physicalDamage * BLEEDMODIFIER * bleedStacks
func PoisonDamage(physicalDamage:float, poisonStacks:int) -> float:
	return physicalDamage * POISONMODIFIER * poisonStacks
func IgniteDamage(fireDamage:float) -> float:
	return fireDamage * IGNITEMODIFIER


func _on_Slow_timeout():
	emit_signal("OnSlowedStop")
