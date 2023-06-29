extends Node3D

@onready var Anim:AnimationPlayer=$AnimationPlayer
@onready var Player:Sprite3D=$Player

var row=0
var camera = null
var AnimName:String

func set_camera(c):
	camera = c
 
func move():
	
	if camera == null:
		return

	$Label.text=name

	if Anim!=null:
		
		var p_fwd = -camera.global_transform.basis.z
		var fwd = global_transform.basis.z
		var left = global_transform.basis.x 
		var l_dot = left.dot(p_fwd)
		var f_dot = fwd.dot(p_fwd)
		
		Player.flip_h = false
		if f_dot < -0.85:
			row = 4 # front sprite
		elif f_dot > 0.85:
			row = 0 # back sprite
		else:
			Player.flip_h = l_dot < 0
			if abs(f_dot) < 0.3:
				row = 2 # left sprite
			elif f_dot < 0:
				row = 3 # forward left sprite
			else:
				row = 1 # back left sprite
		SetAnim(AnimName)

func SetAnim(nome:String):
	AnimName=nome
	if nome!="" and Anim!=null:
		Anim.play(nome+str(row))
