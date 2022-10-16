extends Area2D

export (int) var speed = 200
const arrow_scene = preload("res://Arrow.tscn")

onready var hearts = get_tree().current_scene.get_node("Hearts")
onready var _animated_sprite = $AnimatedSprite
onready var attack_timer = $AttackTimer

var health = 100
var velocity = Vector2()
var health = 4

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
	if Input.is_action_just_released("shoot") and attack_timer.is_stopped():
		shoot_arrow()
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	position += velocity * delta
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

func shoot_arrow():
	var arrow = arrow_scene.instance()
	get_tree().current_scene.add_child(arrow)
	arrow.global_position = global_position
	arrow.rotation = self.global_position.direction_to(get_global_mouse_position()).angle()
	attack_timer.start()

func decrement_health():
	health -= 1
	hearts.decrement_heart()

func _on_Player_body_entered(body):
	if "Mob" in body.name:
		decrement_health()
		body.queue_free()
