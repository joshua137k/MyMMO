
extends Node3D

const Cell = preload("res://Sceane/DugeonCreate/Cell.tscn")

@export var Map:PackedScene

var cells = []

func _ready():
	generate_map()

func generate_map():
	if not Map is PackedScene: return
	var map = Map.instantiate()
	var tileMap:TileMap = await map.get_tilemap()[0]
	var used_tiles = tileMap.get_used_cells(0)
	map.free() # We don't need it now that we have the tile data
	for tile in used_tiles:
		var cell = Cell.instantiate()
		cell.position = Vector3(tile.x*Global.GRID_SIZE, 0, tile.y*Global.GRID_SIZE)
		call_deferred("add_child",cell)
		
		cells.append(cell)
	for cell in cells:
		cell.update_faces(used_tiles)
	
	get_parent().start()
	


	
