class_name Player

extends CharacterBody2D

var speed = 400

# hakee hahmon, johon verrataan onko tarpeeksi lähellä
@onready var npc = get_node("../paavonpc")

@onready var collisionShape = get_node("CollisionShape2D")
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")

var paused = false

#pysäyttää pelin, laittaa PAUSE tekstin näkyviin
func _pause():
	if paused == false:
		Engine.time_scale = 0
		get_node("Pause").visible = true
		paused = !paused
	elif paused:
		Engine.time_scale = 1
		get_node("Pause").visible = false
		paused = !paused
	
# hoitaa liikkumisen
func _get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	
	if velocity != Vector2.ZERO:
		anim.play('run')
	else: 
		anim.play('idle')
	
	if velocity.x < 0:
		anim.flip_h = true
	else:
		anim.flip_h = false
		

# kääntää hahmoa siihen hiiren suuntaan
func _look_at_mouse(delta_value): 
	
	var mouse_position = get_global_mouse_position()
	var target_angle = global_position.angle_to_point(mouse_position)
	var current_angle = collisionShape.rotation
	var angle_diff = wrapf(target_angle - current_angle, -PI, PI)
	
	#print("mouse position","   ", mouse_position)
	#print("target_angle","   ", target_angle)
	#print("current_angle","   ", current_angle)
	#print("angle_diff", "    ", angle_diff)
	var rotation_speed = 15
	
	# lerp() funktio tekee kääntymisestä tasaisempaa 
	# kaksi eri tapaa käsitellä kääntymistä, lerp() paljon monimutkaisempi mutta ase ja hahmo kääntyy erikseen
	# gemini AI:n masinoima funktio
	collisionShape.rotation = lerp(current_angle, current_angle + angle_diff, rotation_speed * delta_value)
	#collisionShape.look_at(mouse_position)
	
	# pitäis kääntää patrikki toisinpäin jos katsoo liikaa alas tai ylös, ei toimi ja käyttäytyy oudosti
	#var angle_radians = global_position.angle_to_point(mouse_position)
	#var angle_degrees = rad_to_deg(angle_radians)
	#var anim = get_node("AnimatedSprite2D")
	#
	#if angle_degrees > -90 and angle_degrees < 90 :
		#anim.flip_v = true
	#else :
		#anim.flip_v = false
	
func _ready():
	pass
	
func _physics_process(delta):
	move_and_slide()
	_get_input()
	#_look_at_mouse(delta)
	
	# jos tarpeeksi lähellä jotain hahmoa, laita tekstipalikka näkyviin
	# tässä esimerkissä hahmo on paavo, hahmo pitää hakea erikseen get_nodella.
	var distance = collisionShape.global_position.distance_to(npc.global_position)
	if distance <= 150:
		get_node("Label").visible = true
	else :
		get_node("Label").visible = false
		
	if Input.is_action_just_pressed("ui_cancel"):
		_pause()
	
	if Input.is_action_just_pressed("ui_focus_next"):
		get_tree().quit()
