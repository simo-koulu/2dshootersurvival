extends CharacterBody2D

var speed : int = Global.export.gun1BulletSpeed
#damage jonka mobit ottaa, haetaan täsät muuttujasta
var damage : int = Global.export.gun1BulletDamage

func initialize(pos):
	transform = pos

func _ready() -> void:
	get_node("Timer").start()
	
func _physics_process(delta):
	move_and_collide(transform.x * speed * delta)

func _on_timer_timeout() :
	queue_free()
	
# jos osuu mobiin, tuhoaa itsensä
# voi lisätä sieiniä tai muita hahmoja jos siltä tuntuu 
# pitää vain lisätä sille hahmolle Area2D ja sille joku ryhmä
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		self.queue_free()
