extends Node2D

@onready var spawner = get_node("Spawner")
@onready var room4DoorSpawn = get_node("../Room4handler/DOOR_UP/Spawn").global_position
@onready var room6DoorSpawn = get_node("../Room6handler/DOOR_LEFT/Spawn").global_position

func _on_player_detector_area_body_entered(body: Node2D) -> void:
	if body == Global.player :
		Global.room5Entered = true
		print("pelaja tuli huoneeseen 5")
		
		# jos huonetta ei vielä tyhjennetty, aloittaa spawnaus prosessin
		if !Global.room5Cleared:
			spawner.set_process(true)
			spawner._spawn_enemies()
			
func _on_player_detector_area_body_exited(body: Node2D) -> void:
	if body == Global.player : 
		Global.room5Entered = false
		print("pelaaja poistui huoneesta 5 ")

func _on_door_down_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room5Cleared :
		Global.player.global_position = room4DoorSpawn

func _on_door_right_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room5Cleared :
		Global.player.global_position = room6DoorSpawn
