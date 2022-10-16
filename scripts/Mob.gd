extends RigidBody2D

const SPEED = 100
const TOL = 0.1

onready var _animated_sprite = $AnimatedSprite
onready var _player = null
onready var dir = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	_animated_sprite.play("Run")

func _physics_process(delta):
	if _player != null:
		dir = (_player.position - position).normalized()
		linear_velocity = dir * SPEED

func _process(delta):
	_animated_sprite.flip_h = dir.x < 0
	
func set_player(player):
	_player = player

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
