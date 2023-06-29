extends Node3D


func setParticle(new,color):
	var j = get_node("spike2").get_node("Spike")
	newcolor(color)
	for i in j.get_child_count():
		j.get_child(i).get_child(1).visible=true
		j.get_child(i).get_child(1).process_material=new


func newcolor(color):
	var j = get_node("spike2").get_node("Spike")
	for i in j.get_child_count():
		j.get_child(i).get_child(0).material_override.albedo_color=color
