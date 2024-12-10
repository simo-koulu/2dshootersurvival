extends Node2D

@onready var spawner = get_node("Spawner")
@onready var room3DoorSpawn = get_node("../Room3handler/DOOR_UP/Spawn").global_position
@onready var room5DoorSpawn = get_node("../Room5handler/DOOR_RIGHT/Spawn").global_position
@onready var room8DoorSpawn = get_node("../Room8handler/DOOR_LEFT/Spawn").global_position

func _on_player_detector_area_body_entered(body: Node2D) -> void:
	if body == Global.player :
		Global.room6Entered = true
		print("pelaja tuli huoneeseen 6")
		
		# jos huonetta ei vielä tyhjennetty, aloittaa spawnaus prosessin
		if !Global.room6Cleared:
			spawner.set_process(true)
			spawner._spawn_enemies()
			
func _on_player_detector_area_body_exited(body: Node2D) -> void:
	if body == Global.player : 
		Global.room6Entered = false
		print("pelaaja poistui huoneesta 6 ")

# ovi alas
func _on_door_down_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room6Cleared :
		Global.player.global_position = room3DoorSpawn

#ovi vasempaan
func _on_door_left_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room6Cleared :
		Global.player.global_position = room5DoorSpawn

# ovi oikeelle
func _on_door_right_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room6Cleared and Global.room4Cleared and Global.room5Cleared and Global.room7Cleared:
		Global.player.global_position = room8DoorSpawn
