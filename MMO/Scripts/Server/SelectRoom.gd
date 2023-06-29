extends Control

func UpdateButtons(data,number):
	visible=true
	for i in range(len(data)):
		var button=Button.new()
		button.name=data[i]
		button.custom_minimum_size=Vector2(200,40)
		button.text=data[i]  + ", PlayersOnline:"+ str(number[i])
		var callback = func(): pressed(data[i])
		button.connect("pressed",callback)
		get_node("ScrollContainer/VBoxContainer").add_child(button)




func pressed(room):
	var room_choice = {'type': 'room_choice','room_id': room}
	get_parent().get_node("Login").send_text(JSON.stringify(room_choice))
