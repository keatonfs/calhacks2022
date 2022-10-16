extends CanvasLayer

onready var user_input = $MarginContainer
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

func set_user_inputs():
	user_name = user_inputs.pop_front()
	pronouns = user_inputs.pop_front()
	nickname = user_inputs.pop_front()
	description = user_inputs.pop_front()

func _on_Button_pressed():
	if input.text != "":
		user_inputs.append(input.text)
		if text_queue.empty():
			user_input.hide()
			set_user_inputs()
		else:
			label.text = text_queue.pop_front()
			input.text = ""
