extends Node3D

# Variáveis
var player_id = -1
var players = {}
var mobs ={}
var MyPlayer
var connect = false

func _ready():
	WebsocketClient.connect("data", _handle_network_data)
	WebsocketClient.connect("disconnected",ErrorConnect)

func start():
	MyPlayer = Global.player.instantiate()
	player_id = Global.myid
	MyPlayer.position = $Marker3D.position
	MyPlayer.get_node("Label").text = Global.username
	players[Global.myid] = MyPlayer
	call_deferred("add_child", MyPlayer)
	$OpenChat.visible = true
	connect = true

func ErrorConnect(_was_clean):
	WebsocketClient.set_process(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://Sceane/MainMenu.tscn")


# Novo Peer
func newplayer(id, username):
	var new = Global.peer.instantiate()
	new.get_node("Label").text = username
	new.name=username+str(id)
	new.position = $Marker3D.position
	players[id] = new
	new.set_camera(MyPlayer.get_node("Pivot/Camera"))
	send_player_position(str(new.position), str(new.rotation), "")
	call_deferred("add_child",new)


# Novo Mob
func newMob(id, username):
	var new = Global.peer.instantiate()
	new.name=username
	new.get_node("Label").text = username
	new.position = $Marker3D.position
	mobs[id] = new
	new.set_camera(MyPlayer.get_node("Pivot/Camera"))
	call_deferred("add_child",new)


# Receber dados do servidor
func _handle_network_data(data):
	var json = JSON.new()
	json.parse(data)

	var message: Dictionary = json.get_data()
	match message.type:
		"player_position":
			UpdateDataPeer(message)
		
		"mobs_data":
			UpdateDataMob(message)
		
		"player_connected":
			send_player_position(str(MyPlayer.position), str(MyPlayer.rotation), MyPlayer.anim)

		"player_disconnected":
			if str(message.id) in players:
				players[str(message.id)].queue_free()
				players.erase(str(message.id))

		"chat_message":
			$Chat/TextEdit.text += message.username + ": " + message.text + "\n"

func UpdateDataPeer(message):
	if message.id not in players:
		newplayer(message.id, message.username)
	players[message.id].visible=message.visible
	
	if message.visible:
		players[message.id].position = str_to_var("Vector3" + message.data[0])
		players[message.id].move()
		players[message.id].rotation = str_to_var("Vector3" + message.data[1])
		players[message.id].SetAnim(message.data[2])


func UpdateDataMob(message):
	if message.id not in mobs:
		newMob(message.id, "Zombie")
	mobs[message.id].visible=message.visible

	if message.visible:
		mobs[message.id].move()
		mobs[message.id].position = str_to_var("Vector3" + message.position)
		mobs[message.id].rotation = str_to_var("Vector3" + message.rotation)
		mobs[message.id].SetAnim(message.Anim)


# Enviar mensagem para o chat
func send_chat_message(nome, text):
	var message = {
		'type': "chat_message",
		'name': nome,
		'text': text
	}
	send_text(JSON.stringify(message))

# Enviar posição do jogador para o chat
func send_player_position(pos: String, rot: String, anim: String):
	if connect:
		var data = [pos, rot, anim]
		var message = {
			'type': 'player_position',
			'id': player_id,
			'data': data
		}
		send_text(JSON.stringify(message))

# Botões

# Enviar mensagem no chat
func _on_send_message_pressed():
	var text = $Chat/LineEdit.text.strip_escapes()
	if text != "":
		send_chat_message(Global.username, text)
		$Chat/TextEdit.text += text + "\n"
		$Chat/LineEdit.clear()

# Fechar chat
func _on_close_pressed():
	MyPlayer.inchat = false
	$Chat.visible = false
	$OpenChat.visible = true

# Abrir chat
func _on_open_chat_pressed():
	MyPlayer.inchat = true
	$Chat.visible = true
	$OpenChat.visible = false

# Fim dos botões

# Enviar mensagem para o servidor
func send_text(text):
	WebsocketClient._send_string(text)
