extends MeshInstance3D


func setParticle(new,color):
	var j = get_child(1)
	j.visible=true
	j.process_material=new
	newcolor(color)
	

func newcolor(color):
	material_override.albedo_color=color
