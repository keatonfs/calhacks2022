extends Node2D

export (PackedScene) var mob_scene
export (PackedScene) var demon_scene
export (PackedScene) var slime_scene
export (PackedScene) var giant_scene

onready var enemy_scenes = [mob_scene, demon_scene, slime_scene, giant_scene]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$StartTimer.start()
	
func end_game():
	$MobTimer.stop()

func _on_MobTimer_timeout():
	var orc = enemy_scenes[randi() % 4].instance()
	#var orc = demon_scene.instance()
	var orc_spawn_node = get_node("MobPath/MobPathSampler")
	orc_spawn_node.offset = randi()
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0)
	var orc_dir = orc_spawn_node.rotation + PI / 2
	
	orc.position = orc_spawn_node.position
	orc.linear_velocity = velocity.rotated(orc_dir)
	# create instance
	add_child(orc)
	orc.set_player($Player)

func _on_StartTimer_timeout():
	$MobTimer.start()
