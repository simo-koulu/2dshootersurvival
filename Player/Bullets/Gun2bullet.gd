extends CharacterBody2D

var speed: int = 700
var damage : float = 120

func initialize(pos):
	transform = pos

func _ready() -> void:
	get_node("Timer").start()
	
func _physics_process(delta):
	var collision = move_and_collide(transform.x * speed * delta)

func _on_timer_timeout() :
	queue_free()
	
# jos osuu mobiin, tuhoaa itsensä
# voi lisätä sieiniä tai muita hahmoja jos siltä tuntuu 
# pitää vain lisätä sille hahmolle Area2D ja sille joku ryhmä
#func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.is_in_group("enemy"):
		#self.queue_free()
