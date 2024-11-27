extends Node2D

func _process(delta: float) -> void:
	#var mouse_position = get_global_mouse_position()
	#
	#var angle_radians = global_position.angle_to_point(mouse_position)
	#var angle_degrees = rad_to_deg(angle_radians)
	#
	#look_at(mouse_position)
	
	var mouse_position = get_global_mouse_position()
	var target_angle = global_position.angle_to_point(mouse_position)
	var current_angle = self.rotation
	var angle_diff = wrapf(target_angle - current_angle, -PI, PI)
	var rotation_speed = 20
	
	# lerp() funktio tekee kääntymisestä tasaisempaa 
	# kaksi eri tapaa käsitellä kääntymistä, lerp() paljon monimutkaisempi mutta ase ja hahmo kääntyy erikseen
	# gemini AI:n masinoima funktio
	self.rotation = lerp(current_angle, current_angle + angle_diff, rotation_speed * delta)
