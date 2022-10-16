extends Area2D

onready var _textbox = get_tree().current_scene.get_node("Textbox")
onready var _user_input = get_tree().current_scene.get_node("UserInput")

const speed = 300
var velocity = Vector2(1, 0)

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * delta * direction

func destroy():
	queue_free()


func _on_Arrow_area_entered(area):
	print("area" + area.name)
	if area.name != "Player":
		destroy()


func _on_Arrow_body_entered(body):
	if "Mob" in body.name:
		if $KillTimer.is_stopped():
			_textbox.get_kill_message(body.enemy_type)
			$KillTimer.start()
		body.queue_free()
	if body.name != "Player":
		destroy()

# prevent too many calls to get_kill_message
func _on_KillTimer_timeout():
	pass
	
