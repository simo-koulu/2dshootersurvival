extends Node2D

@onready var spawner = get_node("Spawner")
@onready var room6DoorSpawn = get_node("../Room6handler/DOOR_RIGHT/Spawn").global_position
@onready var room7DoorSpawn = get_node("../Room7handler/DOOR_UP/Spawn").global_position

func _on_player_detector_area_body_entered(body: Node2D) -> void:
	if body == Global.player :
		Global.room8Entered = true
		print("pelaja tuli huoneeseen 8")
		
		# jos huonetta ei vielä tyhjennetty, aloittaa spawnaus prosessin
		if !Global.room8Cleared:
			spawner.set_process(true)
			spawner._spawn_enemies()
			
func _on_player_detector_area_body_exited(body: Node2D) -> void:
	if body == Global.player : 
		Global.room8Entered = false
		print("pelaaja poistui huoneesta 8 ")

#ovi vasempaan
func _on_door_left_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room8Cleared :
		Global.player.global_position = room6DoorSpawn

# alas
func _on_door_down_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room8Cleared :
		Global.player.global_position = room7DoorSpawn
