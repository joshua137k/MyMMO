extends Control

@onready var username_textbox: LineEdit = get_node("VBoxContainer/username")
@onready var password_textbox: LineEdit = get_node("VBoxContainer/senha")


func _ready():
	WebsocketClient.connect("data", _handle_network_data)


#Register And Login
func _on_login_pressed():
	var username = username_textbox.text
	var password = password_textbox.text
	var message = {"type": "login", "username": username, "password": password}
	send_text(JSON.stringify(message))


func _on_register_pressed():
	var username = username_textbox.text
	var password = password_textbox.text
	var message = {"type": "register", "username": username, "password": password}
	send_text(JSON.stringify(message))
#Register And Login END



#Enviar msg server
func send_text(text):
	WebsocketClient._send_string(text)




#Receber dados do server
func _handle_network_data(data):
	#print("Received server data: ", data)
	var json=JSON.new()
	json.parse(data)
	
	var message: Dictionary = json.get_data() 
	if message.type=="system_message":
		get_parent().get_node("SelectRoom").visible=false
		$Label.text=message.text
	elif message.type=="available_rooms":
		get_parent().get_node("SelectRoom").UpdateButtons(message.rooms,message.number)
		
		
	
	elif message.type=="Logged":
		Global.username=username_textbox.text
		Global.myid=message.id
		get_tree().change_scene_to_file("res://Sceane/game.tscn")


