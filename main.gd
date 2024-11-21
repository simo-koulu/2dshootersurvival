extends Node2D
class_name Main

@onready var paavopreload = preload("res://paavonpc.tscn")

var preloadBullet = preload('res://Bullet.tscn')
var canShoot: bool = true
var fireRate: float = 800		#rounds per minute 
var fireRateTimer: float = 60 / fireRate
#käytetään jos on animoitavaa 
#@onready var anim = get_node("Player/GunNode/AnimatedSprite2D")

func shoot() :
	var b = preloadBullet.instantiate()
	var bulletTransform = get_node('Player/GunNode/BulletStartingPoint').global_transform
	b.initialize(bulletTransform)
	Global.main.add_sibling(b)
	#anim.play('shooting')
	canShoot = false
	return true
	
func can_shoot() :
	await get_tree().create_timer(fireRateTimer).timeout
	canShoot = true
	return true

func _ready() -> void:
	# asettaa tämän kohtauksen "main" kohtaukseksi 
	# voi mistä tahansa skriptistä saada yhteyden tähän "main" nodeen
	# Globa.main == get_tree().get_root().get_node('Main')
	Global.main = self
	# jos haluaa importata hahmoja 
	#rootNode.add_child(paavopreload.instantiate())
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_shoot") and canShoot :
		if shoot() :
				pass
		if await can_shoot():
			pass
