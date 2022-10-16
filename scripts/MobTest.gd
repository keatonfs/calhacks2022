extends Node2D

export (PackedScene) var chort_scene
export (PackedScene) var demon_scene
export (PackedScene) var giant_scene
export (PackedScene) var goblin_scene
export (PackedScene) var ice_zombie_scene
export (PackedScene) var ork_scene
export (PackedScene) var skeleton_scene
export (PackedScene) var slime_scene
export (PackedScene) var zombie_scene


onready var enemy_scenes = [chort_scene, demon_scene, giant_scene, goblin_scene, ice_zombie_scene, ork_scene, skeleton_scene, slime_scene, zombie_scene]
onready var wave = $CanvasLayer
onready var wave_label = $CanvasLayer/MarginContainer/Label

var wave_num = 1
var enemies_remaining_in_wave = 5

# Called when the node enters the scene tree for the first time.
func start_spawning():
	randomize()
	$StartTimer.start()
	wave.show()
	
func end_game():
	$MobTimer.stop()

func _on_MobTimer_timeout():
	var orc = enemy_scenes[randi() % len(enemy_scenes)].instance()
	#var orc = demon_scene.instance()
	var orc_spawn_node = get_node("MobPath/MobPathSampler")
	orc_spawn_node.offset = randi()
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0)
	var orc_dir = orc_spawn_node.rotation + PI / 2
	
	orc.position = orc_spawn_node.position
	orc.linear_velocity = velocity.rotated(orc_dir)
	# create instance
	add_child(orc)
	orc.set_player(get_tree().current_scene.get_node("YSort/Player"))
	enemies_remaining_in_wave -= 1
	$MobTimer.wait_time *= 0.98
	if enemies_remaining_in_wave == 0:
		$MobTimer.set_paused(true)
		$WaveTimer.start()
		
	

func _on_StartTimer_timeout():
	$MobTimer.start()
	wave.hide()


func _on_WaveTimer_timeout():
	$MobTimer.set_paused(false)
	wave_num += 1
	enemies_remaining_in_wave = 5 + wave_num
	wave_label.text = "Wave %d" % [wave_num]
	wave.show()
	$WaveDisplayTimer.start()


func _on_WaveDisplayTimer_timeout():
	wave.hide()
