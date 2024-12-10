extends Node2D

@onready var spawner = get_node("Spawner")
@onready var room2DoorSpawn = get_node("../Room2handler/DOOR_UP/Spawn").global_position
@onready var room4DoorSpawn = get_node("../Room4handler/DOOR_RIGHT/Spawn").global_position
@onready var room6DoorSpawn = get_node("../Room6handler/DOOR_DOWN/Spawn").global_position
@onready var room7DoorSpawn = get_node("../Room7handler/DOOR_LEFT/Spawn").global_position

func _on_player_detector_area_body_entered(body: Node2D) -> void:
	if body == Global.player :
		Global.room3Entered = true
		print("pelaja tuli huoneeseen 3")
		
		# jos huonetta ei vielä tyhjennetty, aloittaa spawnaus prosessin
		if !Global.room3Cleared:
			spawner.set_process(true)
			spawner._spawn_enemies()
			
func _on_player_detector_area_body_exited(body: Node2D) -> void:
	if body == Global.player : 
		Global.room3Entered = false
		print("pelaaja poistui huoneesta 3 ")

# ovi alas
func _on_door_down_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room3Cleared :
		Global.player.global_position = room2DoorSpawn 
		

# ovi vasempaan
func _on_door_left_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room3Cleared :
		Global.player.global_position = room4DoorSpawn

# ovi oikeelle 
func _on_door_right_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room3Cleared and Global.room4Cleared and Global.room5Cleared and Global.room6Cleared:
		Global.player.global_position = room7DoorSpawn

# ovi ylös
func _on_door_up_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room3Cleared and Global.room4Cleared :
		Global.player.global_position = room6DoorSpawn
