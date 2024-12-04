extends Node2D

@onready var room1Spawner = get_node("../enemyspawner")
@onready var room2DoorSpawn = get_node("../Room2handler/Door_down/Spawn").global_position

func _on_player_detector_area_body_entered(body: Node2D) -> void:
	if body == Global.player :
		print("pelaaja tuli huoneeseen 1 ")
		room1Spawner.set_process(true)
		Global.room1Entered = true
	
func _on_player_detector_area_body_exited(body: Node2D) -> void:
	if body == Global.player : 
		print("pelaaja lähti huoneesta 1 ")
		room1Spawner.set_process(false)
		Global.room1Entered = false
		
# ovi ylös 
func _on_door_up_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room1Cleared:
		Global.player.global_position = room2DoorSpawn
