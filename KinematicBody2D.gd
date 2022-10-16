extends "res://Entity.gd"

export (int) var speed = 200

onready var _animated_sprite = $AnimatedSprite

var velocity = Vector2()

const FACING_DIRECTION = {
	LEFT = 0,
	RIGHT = 1
}

var direction = FACING_DIRECTION.LEFT

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		direction = FACING_DIRECTION.RIGHT
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		direction = FACING_DIRECTION.LEFT
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	update_animation()
	
func update_animation():
	if velocity == Vector2.ZERO:
		_animated_sprite.play('idle')
	else:
		_animated_sprite.play('run')
	if direction == FACING_DIRECTION.LEFT:
		_animated_sprite.flip_h = true
	else:
		_animated_sprite.flip_h = false
