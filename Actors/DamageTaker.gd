extends Node
class_name DamageTaker

signal bleed_started()
signal poison_started()
signal fire_started()
signal OnSlowed()
signal OnSlowedStop()
signal dodged(parent)
signal blocked(parent)
signal damage_taken(damage, isCrit, parent, damageSrc)
signal bleed_stopped()
signal poison_stopped()
signal fire_stopped()


onready var dotFire:Timer = $DoTFire
onready var dotPoison:Timer = $DoTPoison
onready var dotBleed:Timer = $DoTBleed
onready var slowTimer:Timer = $Slow

const SLOWCHANCE:float = 0.25
const RESISTANCECAP:float = 0.75
const BLOCKCAP:float = 0.75
const DODGECAP:float = 0.75

const IGNITEMODIFIER:float = 0.5
const POISONMODIFIER:float = 0.1
const BLEEDMODIFIER:float = 0.25
const BLEEDSTACKCAP:int = 8
const POISONSTACKCAP:int = 8


export var armor_rate:float = 0.0
export var block:float = 0.0
export var dodge:float = 0.0

export var fireResistance:float = 0.0
export var cold_resistance:float = 0.0
export(NodePath) var health_path

var currentBleed = 0.0
var bleedDuration = 8
var bleedStacks = 0
var currentIgnite = 0.0
var igniteDuration = 4
var currentPoison = 0.0
var poisonDuration = 4
var poisonStacks = 0
var coldStacks = 0
var health_node:Health
func _ready():
	if dotBleed.connect("timeout",self,"StopBleed"):
		print_debug("Failed to connect")
	if dotPoison.connect("timeout",self,"StopPoison"):
		print_debug("Failed to connect")
	if dotFire.connect("timeout",self,"StopIgnite"):
		print_debug("Failed to connect")
	if dotBleed.get_child(0).connect("timeout",self,"DoBleedDamage"):
		print_debug("Failed to connect")
	if dotPoison.get_child(0).connect("timeout",self,"DoPoisonDamage"):
		print_debug("Failed to connect")
	if dotFire.get_child(0).connect("timeout",self,"DoIgniteDamage"):
		print_debug("Failed to connect")
	health_node = get_node(health_path)


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
	health_node.TakeDotDamage(currentBleed * 0.1)
func DoPoisonDamage():
	health_node.TakeDotDamage(currentPoison * 0.1)
func DoIgniteDamage():
	health_node.TakeDotDamage(currentIgnite * 0.1)

func ResolveHit(damageSrc:DamageSource) -> float:
	var damage:float = 0.0
	if Roll(min(dodge, DODGECAP)):
		emit_signal("dodged", get_parent())
		return 0.0
	if Roll(min(block, BLOCKCAP)):
		emit_signal("blocked", get_parent())
		return 0.0##stun animation
	var crit = Roll(damageSrc.criticalChance)
	var critAsFloat = float(crit)
	if damageSrc.physical > 0.0:
		var physicalDamageReduction:float = PhysicalReduction(armor_rate,damageSrc.physical)
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
		var fireDamageReduction:float = FireDamageReduction()
		var fireDamage = damageSrc.fire
		fireDamage+= fireDamage * critAsFloat * damageSrc.criticalDamage
		fireDamage*= (1 - fireDamageReduction)
		damage += fireDamage
		if Roll(damageSrc.igniteChance):
			ApplyIgnite(fireDamage)
	if damageSrc.cold > 0.0:
		var coldDamageReduction:float = ColdDamageReduction()
		var coldDamage = damageSrc.cold
		coldDamage+= coldDamage * critAsFloat * damageSrc.criticalDamage
		coldDamage*= (1 - coldDamageReduction)
		if Roll(SLOWCHANCE * critAsFloat):
			if slowTimer.is_stopped():
				Slow()
		damage+= coldDamage
	emit_signal("damage_taken", damage, crit, get_parent(), damageSrc)
	health_node.TakeDamage(int(damage))
	return damage
func Slow():
	slowTimer.start()
	emit_signal("OnSlowed")
func PhysicalReduction(armor:float, physicalDamage:float) -> float:
	return armor / (armor + 5.0 * physicalDamage)
func ColdDamageReduction() -> float:
	return min(RESISTANCECAP, cold_resistance)
func FireDamageReduction() -> float:
	return min(RESISTANCECAP, fireResistance)

func Roll(chance:float) -> bool:
	return chance != 0 && randf() <= chance

func ApplyBleed(physicalDamage:float) -> void:
	bleedStacks = min(BLEEDSTACKCAP, bleedStacks + 1)
	var bleedDamage = BleedDamage(physicalDamage, bleedStacks)
	if currentBleed < bleedDamage:
		currentBleed = bleedDamage
	dotBleed.start()
	emit_signal("bleed_started")
	dotBleed.get_child(0).start()

func ApplyIgnite(fireDamage:float) -> void:
	var igniteDamage = IgniteDamage(fireDamage)
	if currentIgnite < igniteDamage:
		currentIgnite = igniteDamage
	dotFire.start()
	emit_signal("fire_started")
	dotFire.get_child(0).start()
func ApplyPoison(physicalDamage:float) -> void:
	poisonStacks = min(POISONSTACKCAP, poisonStacks + 1)
	var poisonDamage = PoisonDamage(physicalDamage, poisonStacks)
	currentPoison += poisonDamage
	dotPoison.start()
	emit_signal("poison_started")
	dotPoison.get_child(0).start()
func BleedDamage(physicalDamage:float, stacks:int) -> float:
	return physicalDamage * BLEEDMODIFIER * stacks
func PoisonDamage(physicalDamage:float, stacks:int) -> float:
	return physicalDamage * POISONMODIFIER * stacks
func IgniteDamage(fireDamage:float) -> float:
	return fireDamage * IGNITEMODIFIER


func _on_Slow_timeout():
	emit_signal("OnSlowedStop")


func _on_DoTFire_timeout():
	emit_signal("fire_stopped")


func _on_DoTPoison_timeout():
	emit_signal("poison_stopped")


func _on_DoTBleed_timeout():
	emit_signal("bleed_stopped")
