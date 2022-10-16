extends CanvasLayer

onready var textbox = get_tree().current_scene.get_node("Textbox")
onready var hearts = get_tree().current_scene.get_node("Hearts")
onready var mob_gen = get_tree().current_scene.get_node("MobGen")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Button_pressed():
	hearts.show()
	mob_gen.start_spawning()
	hide()
	#textbox.start()
