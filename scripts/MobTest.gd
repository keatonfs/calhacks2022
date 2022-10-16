extends Node2D

export (PackedScene) var mob_scene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Player.position = $StartPos.position
	$StartTimer.start()
	
func end_game():
	$MobTimer.stop()

func _on_MobTimer_timeout():
	var orc = mob_scene.instance()
	var orc_spawn_node = get_node("MobPath/MobPathSampler")
	var velocity = Vector2(rand_range(150.0, 250.0), 0)
	
	orc_spawn_node.offset = randi()
	
	orc.position = orc_spawn_node.position
	orc.rotation = orc_spawn_node.rotation + PI / 2
	orc.linear_velocity = velocity.rotated(orc.rotation)
	add_child(orc)

func _on_StartTimer_timeout():
	$MobTimer.start()
