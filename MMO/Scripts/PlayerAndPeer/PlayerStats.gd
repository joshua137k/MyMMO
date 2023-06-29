extends Node
 
signal hurt_signal
signal pick_signal

#@onready var carried_guns = [knife]  # starting weapon
@onready var picked_guns = ["knife"] # starting weapon

#Player variables
var health = 100
var max_health = 100
var armor = 0
var max_armor = 100
var guns_carried = []

var ammo_pistol = 0
var ammo_rocket = 0
var ammo_machinegun = 0

var ammo_max_pistol = 200
var ammo_max_rocket = 10
var ammo_max_machinegun = 400

# weapon on hand
var current_gun = "knife"
 
func reset():
	var _health = 100
	var _max_health = 200
	var _armor = 0
	var _max_armor = 100


 

func take_damage(amount):
	# when the player is hit, check if the amount of damage is bigger than the armor 
	emit_signal("hurt_signal")
	if armor > 0:
		amount = amount - armor
		change_armor(-amount)
	else:
		change_health(-amount)

# sript to change health (use it when the player picks a medkit)
func change_health(amount):
	health += amount
	health = clamp(health, 0, max_health)	
	
# sript to change armor value (use it when the player picks armor)
func change_armor(amount):
	armor += amount
	armor = clamp(armor,0,max_armor)
	
# scripts to change ammo
func change_pistol_ammo(amount):
	ammo_pistol+=amount
	ammo_pistol = clamp(ammo_pistol,0,ammo_max_pistol)

func change_rocket_ammo(amount):
	ammo_rocket+=amount
	ammo_rocket = clamp(ammo_rocket,0,ammo_max_rocket)
		
func change_machinegun_ammo(amount):
	ammo_machinegun+=amount
	ammo_machinegun = clamp(ammo_machinegun,0,ammo_max_machinegun)
	
# this scripts shows the current ammo for each weapon (use it to show the values
# in HUD
func get_pistol_ammo():
	return str(ammo_pistol)

func get_rocket_ammo():
	return str(ammo_rocket)

func get_machinegun_ammo():
	return str(ammo_machinegun)
	
# script to show health value for HUD
func get_health():
	return str(health)
 
# script to show armor value for HUD
func get_armor():
	return str(armor)
