extends Node2D

@onready var spawner = get_node("Spawner")
@onready var room2DoorSpawn = get_node("../Room2handler/Door_down/Spawn").global_position

func _on_player_detector_area_body_entered(body: Node2D) -> void:
	if body == Global.player :
		print("pelaaja tuli huoneeseen 1 ")
		Global.room1Entered = true
		
		# jos huonetta ei vielä tyhjennetty, aloittaa spawnaus prosessin
		if !Global.room1Cleared:
			spawner.set_process(true)
			spawner._spawn_enemies()
	
func _on_player_detector_area_body_exited(body: Node2D) -> void:
	if body == Global.player : 
		print("pelaaja lähti huoneesta 1 ")
		Global.room1Entered = false
		
# ovi ylös 
func _on_door_up_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room1Cleared:
		Global.player.global_position = room2DoorSpawn
