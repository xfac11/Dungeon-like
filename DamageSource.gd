extends Resource
class_name DamageSource
var item
export var cold:float = 0

export var fire:float = 0
export(float, 0, 1) var igniteChance:float = 0

export var physical:float = 0
export(float, 0, 1) var bleedChance:float = 0 ##eg: 0.25 = 25% chance to apply bleed
export(float, 0, 1) var poisonChance:float = 0

export(float, 1, 10) var criticalDamage:float = 1 ##eg: 1 means 100% increased damage
export(float, 0, 1) var criticalChance:float = 0

