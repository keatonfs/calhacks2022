extends Node2D

onready var textbox = $Textbox
onready var player = $YSort/Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_UserInput_visibility_changed():
	textbox.show()
	player.show()
