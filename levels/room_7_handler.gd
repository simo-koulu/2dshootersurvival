extends Node2D

@onready var spawner = get_node("Spawner")
@onready var room3DoorSpawn = get_node("../Room3handler/DOOR_RIGHT/Spawn").global_position
@onready var room8DoorSpawn = get_node("../Room8handler/DOOR_DOWN/Spawn").global_position

func _on_player_detector_area_body_entered(body: Node2D) -> void:
	if body == Global.player :
		Global.room7Entered = true
		print("pelaja tuli huoneeseen 7")
		
		# jos huonetta ei vielä tyhjennetty, aloittaa spawnaus prosessin
		if !Global.room7Cleared:
			spawner.set_process(true)
			spawner._spawn_enemies()
			
func _on_player_detector_area_body_exited(body: Node2D) -> void:
	if body == Global.player : 
		Global.room7Entered = false
		print("pelaaja poistui huoneesta 7 ")

#ovi vasempaan
func _on_door_left_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room7Cleared :
		Global.player.global_position = room3DoorSpawn

# ovi ylös
func _on_door_up_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room7Cleared :
		Global.player.global_position = room8DoorSpawn
