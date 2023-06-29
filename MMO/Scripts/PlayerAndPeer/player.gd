extends CharacterBody3D

@onready var pivot_pos = $Pivot.transform.origin

# basic variables
var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002
var current_gun = 0 # knife
var inchat=false
var idle:bool=true
var anim:String=""

func _ready():
	PlayerStats.connect("hurt_signal", show_blood_overlay)
	PlayerStats.connect("pick_signal", show_pick_overlay)
	# not showing the mouse cursor on game
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#get_tree().call_group("Enemy", "set_camera", self)
	# equip the first gun in our inventory:

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed("move_backward"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("strafe_left"):
		input_dir += -global_transform.basis.x
	if Input.is_action_pressed("strafe_right"):
		input_dir += global_transform.basis.x
		
	# cancel strafe running
	input_dir = input_dir.normalized()
	return input_dir
func _input(event):
	$Label2.text="pos:"+str(position)+" rot:"+str(rotation)
	# move camera with mouse
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)
		get_parent().send_player_position(str(position), str(rotation), anim)


func verifyCells():

	for i in get_tree().get_nodes_in_group("peer"):
		i.move()



func _physics_process(delta):
	#gravity
	verifyCells()
	
	velocity.y += gravity * delta
	
	#velocity movement
	var desired_velocity = get_input() * max_speed
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	move_and_slide()
	
	# animation for walking
	if abs(velocity.x) > 0:
		idle=true
		$AnimationPlayer.play("walk")
		anim="walk_"
		get_parent().send_player_position(str(position), str(rotation), anim)
	else:
		
		$AnimationPlayer.play("idle")
		anim="idle_"
		if idle:
			get_parent().send_player_position(str(position), str(rotation), anim)
			idle=false

	
func show_blood_overlay():
	# flash a red screen when the player is hit 
	if not $Pivot/Camera/AnimationPlayer.is_playing():
		$Pivot/Camera/AnimationPlayer.play("bleeds")
	
func show_pick_overlay():
	# show a flash screen when the player picks ammo, medkits o weapons
	if not $Pivot/Camera/AnimationPlayer.is_playing():
		$Pivot/Camera/AnimationPlayer.play("pick")



