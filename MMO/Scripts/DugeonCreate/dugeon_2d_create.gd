
extends TileMap


func _ready():
	var t = get_used_cells(0)
	var h =get_used_cells_by_id(0,-1,Vector2(3,2))
	var c = get_used_cells_by_id(0,-1,Vector2(3,5))
	var data={}
	for i in t:
		if i in c or i in h:
			data[i*2]=1
		else:
			data[i*2]=0
	print(data)



