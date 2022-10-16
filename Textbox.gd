extends CanvasLayer

const CHAR_READ_RATE = 0.05

onready var textbox_container = $TextboxContainer
onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label2

enum State {
	NOT_READY
	TUTORIAL,
	READY,
	READING
}

var current_state = State.NOT_READY
var text_queue = []
var tutorial_text_queue = ["Welcome to the Arena! (Press Enter to Continue)", "Move around with the arrow keys (Press Enter to Continue)", "Click the mouse to swing your sword (Press Enter to Continue)", "Good Luck!"]

func _ready():
	print("Starting state: State.READY")


func _process(delta):
	match current_state:
		State.TUTORIAL:
			if !tutorial_text_queue.empty():
				display_text(tutorial_text_queue.pop_front())
		State.READY:
			if !tutorial_text_queue.empty():
				if Input.is_action_just_pressed("ui_accept"):
					display_text(tutorial_text_queue.pop_front())
			elif !text_queue.empty():
				display_text(text_queue.pop_front())
		State.READING:
			pass


func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()
	
func display_text(next_text):
	end_symbol.text = ""
	label.text = next_text
	label.percent_visible = 0.0
	change_state(State.READING)
	show_textbox()
	$Tween.interpolate_property(label, "percent_visible", 0.0, 1.0, len(next_text) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	end_symbol.text = "*"
	change_state(State.READY)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to State.READY")
			pass
		State.READING:
			print("Changing state to State.READING")
			pass


func _on_Textbox_visibility_changed():
	current_state = State.TUTORIAL
	display_text(tutorial_text_queue.pop_front())
