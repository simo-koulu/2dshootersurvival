extends Node2D

@onready var preloadBullet = preload('res://Player/Bullets/Assaultriflebullet.tscn')
@onready var bulletStartingPoint = self.get_node("Bulletstartingpoint")

var canShoot: bool = true
var fireRate : float = Global.export.gun1Firerate
var fireRateTimer: float = 60 / fireRate
@onready var shooting_sound = $AudioStreamPlayer2D

func shoot() :
	var bullet = preloadBullet.instantiate()
	bullet.initialize(bulletStartingPoint.global_transform)
	Global.main.add_sibling(bullet)
	if Global.camera.trauma <= 70 / 100 : 
		Global.camera.add_trauma(50, 9)
	shooting_sound.play()
	shooting_sound.pitch_scale = randf_range(0.7, 0.8)
		
	canShoot = false
	return true
	
func can_shoot() :
	await get_tree().create_timer(fireRateTimer).timeout
	canShoot = true
	return true

func _ready() -> void:
	pass

func _process(delta) -> void :
	# flippaa aseen spriten peilikuvaksi, poista kommentointi ja vaihda anim-muuttujaan spriten nimi
	#if angle_degrees > -90 and angle_degrees < 90 :
		#anim.flip_v = false
		#
	#else :
		#anim.flip_v = true
		
	if Input.is_action_pressed("ui_shoot") and canShoot :
		if shoot() :
			pass
		if await can_shoot():
			pass
