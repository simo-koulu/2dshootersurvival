extends Node2D

@onready var room1DoorSpawn = get_node("../Room1handler/DOOR_UP/Spawn").global_position
@onready var room3DoorSpawn = get_node("../Room3handler/DOOR_DOWN/Spawn").global_position

@onready var spawner = get_node("Spawner")

func _on_player_detector_area_body_entered(body: Node2D) -> void:
	if body == Global.player :
		Global.room2Entered = true
		print("pelaja tuli huoneeseen 2")
		
		# jos huonetta ei vielä tyhjennetty, aloittaa spawnaus prosessin
		if !Global.room2Cleared:
			spawner.set_process(true)
			spawner._spawn_enemies()

func _on_player_detector_area_body_exited(body: Node2D) -> void:
	if body == Global.player : 
		Global.room2Entered = true
		print("pelaaja lähti huoneesta 2 ")

# ovi alas 
func _on_door_down_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room2Cleared :
		Global.player.global_position = room1DoorSpawn

# ovi ylös
func _on_door_up_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room2Cleared :
		Global.player.global_position = room3DoorSpawn
