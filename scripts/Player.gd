extends KinematicBody2D

export (int) var speed = 200
const arrow_scene = preload("res://Arrow.tscn")

onready var hearts = get_tree().current_scene.get_node("Hearts")
onready var try_again_button = get_tree().current_scene.get_node("TryAgain")
onready var _textbox = get_tree().current_scene.get_node("Textbox")
onready var _animated_sprite = $AnimatedSprite
onready var attack_timer = $AttackTimer
onready var bow_sfx = $AudioStreamPlayer2D

var velocity = Vector2()
var health = 4

const FACING_DIRECTION = {
	LEFT = 0,
	RIGHT = 1
}

var direction = FACING_DIRECTION.LEFT

func get_input():
	if !visible:
		return
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

func shoot_arrow():
	if visible:
		var arrow = arrow_scene.instance()
		get_tree().current_scene.add_child(arrow)
		arrow.global_position = global_position
		arrow.rotation = self.global_position.direction_to(get_global_mouse_position()).angle()
		attack_timer.start()
		bow_sfx.play()

func decrement_health(mob_name):
	health -= 1
	hearts.decrement_heart()
	if health == 0:
		_textbox.get_death_message(mob_name)
		try_again_button.show()
		$CollisionShape2D2.set_disabled(true)
		hide()
	else:
		_textbox.get_damage_message(mob_name, health * 25)

