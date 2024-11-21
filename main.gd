extends Node2D
class_name Main

@onready var paavopreload = preload("res://paavonpc.tscn")

var max_mobs : int

#aseen muuttujat 
var preloadBullet = preload('res://Bullet.tscn')
var canShoot: bool = true
var fireRate: float = 800		#rounds per minute 
var fireRateTimer: float = 60 / fireRate
#käytetään jos on animoitavaa 
#@onready var anim = get_node("Player/GunNode/AnimatedSprite2D")

func shoot() :
	var bullet = preloadBullet.instantiate()
	bullet.initialize(get_node('Player/GunNode/BulletStartingPoint').global_transform)
	Global.main.add_sibling(bullet)
	canShoot = false
	return true
	
func can_shoot() :
	await get_tree().create_timer(fireRateTimer).timeout
	canShoot = true
	return true

#tähän tulee sit hyökkäyslogiikkaa mut täl hetkel ei tee viel mitää muuta ku sano "moro"
func _on_enemyspawner_hit_p():
	print("moro :DDDDDDD")

func _ready() -> void:
	Global.main = self
	
	#oli 20 alunperin
	max_mobs = 40
	# jos haluaa importata hahmoja 
	#rootNode.add_child(paavopreload.instantiate())
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_shoot") and canShoot :
		if shoot() :
			pass
		if await can_shoot():
			pass
