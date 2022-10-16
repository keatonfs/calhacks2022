extends Area2D

const speed = 300
var velocity = Vector2(1, 0)

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * delta * direction

func destroy():
	queue_free()


func _on_Arrow_area_entered(area):
	if area.name != "Player":
		destroy()


func _on_Arrow_body_entered(body):
	if body.name != "Player":
		destroy()
