
extends Node3D
class_name Cell




func update_faces(cell_list) -> void:
	var my_grid_position = Vector2i(position.x/Global.GRID_SIZE, position.z/Global.GRID_SIZE)
	if (my_grid_position + Vector2i.RIGHT) in cell_list:
		$EastFace.queue_free()
	if(my_grid_position + Vector2i.LEFT) in  cell_list:
		$WestFace.queue_free()
	if (my_grid_position + Vector2i.DOWN) in cell_list:
		$SouthFace.queue_free()
	if (my_grid_position + Vector2i.UP) in cell_list:
		$NorthFace.queue_free()


