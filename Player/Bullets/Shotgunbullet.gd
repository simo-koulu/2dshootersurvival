extends CharacterBody2D

@onready var timer = get_node("Timer")

var speed : int = randi_range(Global.export.gun4BulletSpeed[0], Global.export.gun4BulletSpeed[1])
#damage jonka mobit ottaa, haetaan täsät muuttujasta
var damage : int = Global.export.gun4BulletDamage
var damageDecay : float = Global.export.gun4PelletDecay
var initialPos : Vector2 = Vector2.ZERO

func initialize(pos, angle):
	global_position = pos
	global_rotation_degrees = angle

func _ready() -> void:
	timer.start()
	initialPos = global_position
	
func _physics_process(delta):
	move_and_collide(transform.x * speed * delta)
	
	var distanceTraveled = global_position.distance_to(initialPos)

	if distanceTraveled > 320 :
		damage = damage - ((distanceTraveled + 320) * damageDecay)
		damage = max(1, damage)
		
func _on_timer_timeout() :
	queue_free()
	
# jos osuu mobiin, tuhoaa itsensä
# voi lisätä sieiniä tai muita hahmoja jos siltä tuntuu 
# pitää vain lisätä sille hahmolle Area2D ja sille joku ryhmä
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		self.queue_free()
