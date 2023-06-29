extends Control


func _ready():
	
	WebsocketClient.connect("error",ErrorConnect)
	WebsocketClient.connect("connected",Connected)
	WebsocketClient.connect("disconnected",ErrorConnect)

func _on_connect_pressed():
	WebsocketClient.connect_to_server("0.tcp.eu.ngrok.io:17210")
	


func ErrorConnect(_was_clean):
	get_parent().get_node("Login").visible=false
	get_parent().get_node("SelectRoom").visible=false
	visible=true
	$Label.text="SERVER DESLIGADO"

func Connected():
	visible=false
	
	get_parent().get_node("Login").visible=true



func _on_exit_pressed():
	get_tree().quit()
