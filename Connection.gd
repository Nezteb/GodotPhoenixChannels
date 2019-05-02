extends Node

var phoenix : PhoenixSocket

func _ready():
	phoenix = PhoenixSocket.new("ws://localhost:4000/socket", {
		heartbeat_interval = 5000,
		params = {user_id = 4}
	})
	#phoenix.connect("on_event", self, "_on_channel_event")
	phoenix.connect("on_open", self, "_on_Phoenix_socket_open")
	phoenix.connect("on_close", self, "_on_Phoenix_socket_close")
	phoenix.connect("on_error", self, "_on_Phoenix_socket_error")
	phoenix.connect("on_connecting", self, "_on_Phoenix_socket_connecting")
	
	get_parent().call_deferred("add_child", phoenix, true)
	phoenix.connect_socket()	

func _on_Phoenix_socket_open(payload):
	print("_on_Phoenix_socket_open: ", " ", payload)
	
func _on_Phoenix_socket_close(payload):
	print("_on_Phoenix_socket_close: ", " ", payload)
	
func _on_Phoenix_socket_error(payload):
	print("_on_Phoenix_socket_error: ", " ", payload)
	
func _on_channel_event(event, payload):
	print("received phoenix broadcast: ", event, ", ", payload)
	
func _on_Phoenix_socket_connecting(is_connecting):
	print("_on_Phoenix_socket_connecting: ", " ", is_connecting)

func _on_Button_pressed():
	phoenix.disconnect_socket()
	
func _on_Button2_pressed():
	phoenix.connect_socket()	
