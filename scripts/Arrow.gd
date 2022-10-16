extends Area2D

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
		print(body.enemy_type)
		body.queue_free()
	if body.name != "Player":
		destroy()
