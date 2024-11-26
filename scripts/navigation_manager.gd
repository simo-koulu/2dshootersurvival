extends Node

const scene_Main = "res://levels/Main.tscn"
const scene_vasenala = "res://levels/vasenala.tscn"

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"Main":
			scene_to_load = scene_Main
		"vasenala":
			scene_to_load = scene_vasenala
			
	print(level_tag,"    ", destination_tag)
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_file.bind(scene_to_load).call_deferred()
  
func trigger_player_spawn(position: Vector2, direction: String):
	Global.main.add_child(Global.player)
	print("trigger_playeR_spawn")
	on_trigger_player_spawn.emit(position, direction)
