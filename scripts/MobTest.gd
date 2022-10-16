extends Node2D

export (PackedScene) var mob_scene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const TOL = 0.1

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
	orc_spawn_node.offset = randi()
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0)
	var orc_dir = orc_spawn_node.rotation + PI / 2
	
	orc.position = orc_spawn_node.position
	orc.linear_velocity = velocity.rotated(orc_dir)
	add_child(orc)
	if abs(orc_dir - PI) < TOL:
		orc.flip()

func _on_StartTimer_timeout():
	$MobTimer.start()
