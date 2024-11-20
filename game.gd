extends Node2D

@onready var rootNode = get_tree().get_root().get_node('Game')

@onready var paavopreload = preload("res://paavonpc.tscn")

var preloadBullet = preload('res://Bullet.tscn')
var canShoot: bool = true
var fireRate: float = 800		#rounds per minute 
var fireRateTimer: float = 60 / fireRate
#käytetään jos on animoitavaa 
#@onready var anim = get_node("Player/GunNode/AnimatedSprite2D")

func shoot(pos) :
	var b = preloadBullet.instantiate()
	b.initialize(pos)
	rootNode.add_sibling(b)
	#anim.play('shooting')
	canShoot = false
	return true
	
func can_shoot() :
	await get_tree().create_timer(fireRateTimer).timeout
	canShoot = true
	return true

func _ready() -> void:
	# jos haluaa importata hahmoja 
	#rootNode.add_child(paavopreload.instantiate())
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_shoot") and canShoot :
		var bulletTransform = get_node('Player/GunNode/BulletStartingPoint').global_transform
		if shoot(bulletTransform) :
				pass
		if await can_shoot():
			pass
