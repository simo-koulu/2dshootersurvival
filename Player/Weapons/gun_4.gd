extends Node2D

@onready var anim = get_node("AnimatedSprite2D")
@onready var preloadBullet = preload('res://Player/Bullets/Gun4bullet.tscn')
@onready var bulletStartingPoint = self.get_node("Bulletstartingpoint")

var canShoot: bool = true
var fireRate : float = Global.export.gun4FireRate		#rounds per minute 
var fireRateTimer: float = 60 / fireRate
var numberofPellets : int = Global.export.gun4Pellets
var pelletSpread : float 
var randomness : int = Global.export.gun4SpreadRandomness

func shoot() :
	pelletSpread = Global.export.gun4Spread
	pelletSpread = randf_range(pelletSpread - randomness, pelletSpread + randomness)
	var pelletAngle : float = get_parent().rotation_degrees - pelletSpread / 2
	Global.camera.add_trauma(70, 3.2)
	for i in numberofPellets :
		var bullet = preloadBullet.instantiate()
		bullet.initialize(bulletStartingPoint.global_position, pelletAngle)
		Global.main.add_sibling(bullet)
		pelletAngle = pelletAngle + pelletSpread / numberofPellets
	canShoot = false
	return true
	
func can_shoot() :
	await get_tree().create_timer(fireRateTimer).timeout
	canShoot = true
	return true

func _ready() -> void:
	anim.play("default")

func _process(_delta) -> void :
	if Input.is_action_pressed("ui_shoot") and canShoot :
		if shoot() :
			pass
		if await can_shoot():
			pass
