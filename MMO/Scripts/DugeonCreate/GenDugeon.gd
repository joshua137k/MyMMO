extends Node

@export var level_size := Vector2i(100, 80)
@export var rooms_size := Vector2i(10, 14)
@export var rooms_max := 15
var rooms := []
var posIni:Vector2

func _generate_data() -> Array:
	var rng := RandomNumberGenerator.new()
	rng.randomize()

	var data := {}
	
	for r in range(rooms_max):
		var room
		if r ==0:
			room = Rect2(0, 0, 10, 10)
		else:
			room = _get_random_room(rng)
		if _intersects(rooms, room):
			continue

		_add_room(data, rooms, room)
		if rooms.size() > 1:
			var room_previous: Rect2 = rooms[-2]
			_add_connection(rng, data, room_previous, room)

	return data.keys()


func _get_random_room(rng: RandomNumberGenerator) -> Rect2:
	var width := rng.randi_range(rooms_size.x, rooms_size.y)
	var height := rng.randi_range(rooms_size.x, rooms_size.y)
	var x := rng.randi_range(0, level_size.x - width - 1)
	var y := rng.randi_range(0, level_size.y - height - 1)
	return Rect2(x, y, width, height)


func _add_room(data: Dictionary, rooms: Array, room: Rect2) -> void:
	rooms.push_back(room)
	for x in range(room.position.x, room.end.x):
		for y in range(room.position.y, room.end.y):
			data[Vector2i(x, y)] = 1


func _add_connection(rng: RandomNumberGenerator, data: Dictionary, room1: Rect2, room2: Rect2) -> void:
	var room_center1 := (room1.position + room1.end) / 2
	var room_center2 := (room2.position + room2.end) / 2
	if rng.randi_range(0, 1) == 0:
		_add_corridor(data, room_center1.x, room_center2.x, room_center1.y, 0)
		_add_corridor(data, room_center1.y, room_center2.y, room_center2.x, 1)
	else:
		_add_corridor(data, room_center1.y, room_center2.y, room_center1.x, 1)
		_add_corridor(data, room_center1.x, room_center2.x, room_center2.y, 0)


func _add_corridor(data: Dictionary, start: int, end: int, constant: int, axis: int) -> void:
	for t in range(min(start, end), max(start, end) + 1):
		var point := Vector2.ZERO
		match axis:
			0: point = Vector2i(t, constant)
			1: point = Vector2i(constant, t)
		data[point] = null


func _intersects(rooms: Array, room: Rect2) -> bool:
	var out := false
	for room_other in rooms:
		if room.intersects(room_other):
			out = true
			break
	return out
