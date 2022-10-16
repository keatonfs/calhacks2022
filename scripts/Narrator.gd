extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var _http = $HTTPRequest


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Button_pressed():
	_http.request("http://127.0.0.1:5000/take-damage?name=Keaton&enemy=Demon&health=100")

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
