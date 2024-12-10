extends Node2D

@onready var spawner = get_node("Spawner")
@onready var room3DoorSpawn = get_node("../Room3handler/DOOR_LEFT/Spawn").global_position
@onready var room5DoorSpawn = get_node("../Room5handler/DOOR_DOWN/Spawn").global_position

func _on_player_detector_area_body_entered(body: Node2D) -> void:
	if body == Global.player :
		Global.room4Entered = true
		print("pelaja tuli huoneeseen 4")
		
		# jos huonetta ei vielä tyhjennetty, aloittaa spawnaus prosessin
		if !Global.room4Cleared:
			spawner.set_process(true)
			spawner._spawn_enemies()
			
func _on_player_detector_area_body_exited(body: Node2D) -> void:
	if body == Global.player : 
		Global.room4Entered = false
		print("pelaaja poistui huoneesta 4 ")

func _on_door_right_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room4Cleared :
		Global.player.global_position = room3DoorSpawn


func _on_door_up_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room4Cleared :
		Global.player.global_position = room5DoorSpawn
