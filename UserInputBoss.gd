extends CanvasLayer

onready var label = $MarginContainer/MarginContainer/VBoxContainer/Label
onready var input = $MarginContainer/MarginContainer/VBoxContainer/LineEdit
onready var button = $MarginContainer/MarginContainer/VBoxContainer/Button

var user_name = ""
var nickname = ""
var pronouns = ""
var description = ""

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var text_queue = ["Enter your pronouns", "Enter your nickname", "Describe yourself in a few words"]
var user_inputs = []

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = "Enter your name!"

func _process(delta):
	if visible and Input.is_action_just_pressed("ui_accept"):
		_on_Button_pressed()

func set_user_inputs():
	user_name = user_inputs.pop_front().replace(" ", "%20")
	pronouns = user_inputs.pop_front().replace(" ", "%20")
	nickname = user_inputs.pop_front().replace(" ", "%20")
	description = user_inputs.pop_front().replace(" ", "%20")

func _on_Button_pressed():
	if input.text != "":
		user_inputs.append(input.text)
		if text_queue.empty():
			hide()
			set_user_inputs()
		else:
			label.text = text_queue.pop_front()
			input.text = ""

