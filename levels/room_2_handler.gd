extends Node2D

@onready var room1DoorSpawn = get_node("../Room1handler/Door_up/Spawn").global_position
@onready var room3DoorSpawn = get_node("../Room3handler/Door_down/Spawn").global_position

func _on_player_detector_area_body_entered(body: Node2D) -> void:
	if body == Global.player : 
		print("pelaja tuli huoneeseen 2")

func _on_player_detector_area_body_exited(body: Node2D) -> void:
	if body == Global.player : 
		print("pelaaja lähti huoneesta 2 ")

# ovi alas 
func _on_door_down_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room1Cleared :
		Global.player.global_position = room1DoorSpawn

# ovi ylös
func _on_door_up_body_entered(body: Node2D) -> void:
	if body == Global.player and Global.room3Cleared :
		Global.player.global_position = room3DoorSpawn
