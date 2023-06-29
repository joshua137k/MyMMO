extends CanvasLayer

# if tha player has armor, then use this line of code to show the amount of
# armor in the HUD
#onready var armor = $MarginContainer/Control/ArmorLabel
@onready var health = $MarginContainer/Control/GridContainer/HealthLabel
@onready var ammo = $MarginContainer/Control/GridContainer/AmmoLabel

func _process(_delta):
	var current_gun = PlayerStats.current_gun
	# gets armor amount:
	#armor.text = PlayerStats.get_armor()
	health.text = PlayerStats.get_health()
	
	
	# show current ammo of each gun
	if current_gun == "Knife":
		ammo.text = "-"
