extends Node

signal connected
signal data
signal disconnected
signal error

# Our WebSocketClient instance
var _client = WebSocketPeer.new()

var Opened:bool

func _ready():
	_client.inbound_buffer_size=65535*5
	_client.max_queued_packets=65535*5
	_client.outbound_buffer_size=65535*5
	set_process(false)




func _process(_delta):
	
	_client.poll()
	
	var state = _client.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		while _client.get_available_packet_count():
			_on_data()

	elif state == WebSocketPeer.STATE_CLOSED:
		_closed()





func connect_to_server(hostname: String) -> void:
	# Connects to the server or emits an error signal.
	# If connected, emits a connect signal.
	#http://
	var websocket_url ="ws://"+hostname#+":"+ str(port)#+"/ws/0"
	print(websocket_url)
	#tls=
	var err = _client.connect_to_url(websocket_url)
	if err:
		print("Unable to connect")
		set_process(false)
		emit_signal("error")
	_connected()
	
	


func _closed(was_clean = false):
	var _code = _client.get_close_code()
	var _reason = _client.get_close_reason()
	print("Closed, clean: ", was_clean)
	set_process(false)
	emit_signal("disconnected", was_clean)


func _connected(proto = ""):
	set_process(true)
	print("Connected with protocol: ", proto)
	emit_signal("connected")

func _on_data():
	var data_msg: String = _client.get_packet().get_string_from_utf8()
	emit_signal("data", data_msg)


func _send_string(string: String) -> void:
	_client.put_packet(string.to_utf8_buffer())
	#print("Sent string ", string)
