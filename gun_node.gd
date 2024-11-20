extends Node2D

# tilalla musta viiva Line2D 
# vaihda aseen textuuriin, ja vaihda tähän sen Spriten nimi
#@onready var anim = get_node('Line2D')

func _ready() -> void:
	pass

func _process(delta) -> void :
	var mouse_position = get_global_mouse_position()
	
	var angle_radians = global_position.angle_to_point(mouse_position)
	var angle_degrees = rad_to_deg(angle_radians)
	
	look_at(mouse_position)
	
	
	# flippaa aseen spriten peilikuvaksi, poista kommentointi ja vaihda anim-muuttujaan spriten nimi
	#if angle_degrees > -90 and angle_degrees < 90 :
		#anim.flip_v = false
		#
	#else :
		#anim.flip_v = true
