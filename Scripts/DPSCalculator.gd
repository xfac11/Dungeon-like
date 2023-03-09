extends Node
class_name DPSCalculator
var weapons = Dictionary()
var damagePerWeaponSecond = Dictionary()
var dps = Dictionary()
var time = 0.0
var timeTen = 0.0
func on_damage(damage, isCrit, parent, damageSrc):
	if !weapons.has(damageSrc.item):
		weapons[damageSrc.item] = damage
		damagePerWeaponSecond[damageSrc.item] = damage
	else:
		weapons[damageSrc.item] += damage
		damagePerWeaponSecond[damageSrc.item] += damage

func _process(delta):
	time += delta
	timeTen += delta
	if timeTen >= 10.0:
		timeTen = 0
		for weapon in weapons:
			var damage = damagePerWeaponSecond[weapon]
			damagePerWeaponSecond[weapon] = 0
			dps[weapon] = damage/10.0
		print(get_damage_info())
	


func get_damage_info():
	var info = ""
	for weapon in dps:
		var dpsInfo = dps[weapon]
		var damageTotalInfo = weapons[weapon]
		var itemName = weapon.name if "name" in weapon else weapon
		info+= str(itemName) + " " + str(dpsInfo) + " " + str(damageTotalInfo) + "\n"
	return info
