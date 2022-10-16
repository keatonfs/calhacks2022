extends RigidBody2D

onready var _animated_sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	_animated_sprite.play("Run")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
