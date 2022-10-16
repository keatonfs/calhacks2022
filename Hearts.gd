extends CanvasLayer

onready var heart1 = $MarginContainer/HBoxContainer/TextureRect
onready var heart2 = $MarginContainer/HBoxContainer/TextureRect2
onready var heart3 = $MarginContainer/HBoxContainer/TextureRect3
onready var heart4 = $MarginContainer/HBoxContainer/TextureRect4
onready var curr_heart = heart1

func decrement_heart():
	curr_heart.hide()
	if curr_heart == heart1:
		curr_heart = heart2
	elif curr_heart == heart2:
		curr_heart = heart3
	else:
		curr_heart = heart4

