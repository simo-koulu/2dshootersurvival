extends Node2D

@onready var room2DoorSpawn = get_node("../Room2handler/Door_up/Spawn").global_position
#@onready var room4DoorSpawn = get_node("../Room4handler/door_right/Spawn").global_position
#@onready var room5DoorSpawn = get_node("../Room5handler/door_left/Spawn").global_position

func _on_player_detector_area_body_entered(body: Node2D) -> void:
	if body == Global.player : 
		print("pelaaja tuli huoneeseen 3 ")

func _on_player_detector_area_body_exited(body: Node2D) -> void:
	if body == Global.player : 
		print("pelaaja poistui huoneesta 3 ")

# ovi alas
func _on_door_down_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room2Cleared :
		Global.player.global_position = room2DoorSpawn 
		

# ovi vasempaan
#func _on_door_left_body_entered(body: Node2D) -> void:
	#if body == Global.player and room4Cleared :
		#Global.player.global_position = room4DoorSpawn

# ovi oikeelle 
#func _on_door_right_body_entered(body: Node2D) -> void:
	#if body == Global.player and room5Cleared :
		#Global.player.global_position = room5DoorSpawn
