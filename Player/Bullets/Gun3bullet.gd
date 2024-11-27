extends CharacterBody2D

var speed: int = 0
var damage : float = 1000

func initialize(pos):
	transform = pos

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	get_node("Area2D/CollisionShape2D").queue_free()
	
func _physics_process(delta):
	#var collision = move_and_collide(transform.x * speed * delta)
	self.modulate.a = lerp(modulate.a, 0.0, 10 * delta)
	if  modulate.a <= 0:
		queue_free()
		
# jos osuu mobiin, tuhoaa itsensä
# voi lisätä sieiniä tai muita hahmoja jos siltä tuntuu 
# pitää vain lisätä sille hahmolle Area2D ja sille joku ryhmä
#func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.is_in_group("enemy"):
		#self.queue_free()
