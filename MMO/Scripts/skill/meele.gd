extends Node3D


func setParticle(new,_color):
	var j = get_child(2)
	j.visible=true
	j.process_material=new
