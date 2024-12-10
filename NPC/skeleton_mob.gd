extends CharacterBody2D

@onready var player = Global.player
@onready var animation = $AnimatedSprite2D
#@onready var bloodAnim = $Bloodanimation
@onready var area2d = get_node("Area2D")
@onready var healthBar = get_node("Healthbar")
@onready var roomCenter = get_parent().get_parent().get_node("PlayerDetectorArea/PlayerDetector")

var entered : bool = false
var direction : Vector2

#nämä arvot spawneri antaa mobille kun se spawnaa
var speed : int 
var health : float
var damage : int

func _ready():
	direction = roomCenter.global_position - global_position
	animation.flip_h = direction.x > 0
	healthBar._init_bar(health)
	get_node("Timer").start()
	animation.play("idle")
	print("LUURANKO")

func _physics_process(delta):
	if entered:
		animation.play("walk")
		
		direction = (player.global_position - global_position).normalized()
		direction = direction.normalized()
		move_and_collide(direction * speed * delta)
		
		#kääntää animaation riippuen mobin kulkusuunnasta
		
		animation.flip_h = direction.x > 0

	while area2d.global_position.distance_to(player.global_position) <= 100  and health > 0 and entered:
		# kääntää mobin pelaajaa päin, muuten saataisi jäädä huitomaan väärään suuntaan
		if player.global_position.x - self.global_position.x < 0 :
			animation.flip_h = false
		else : 
			animation.flip_h = true
		
		self.set_physics_process(false)
		# varmaan tähän väliin se koodi, joka vahingoitta pelaajaa eli hit_player.emit() ??? ja siihen jotain muokkausta
		# suorittaa pelaajan skriptistä funktion joka vähentää siltä elämää
		# vois ehkä käyttää signaaleja mutta ei ne varmaa ois parempia 
		player._got_hit(damage)
		animation.play("attack")
		await animation.animation_finished
		self.set_physics_process(true)
		await get_tree().create_timer(1.5).timeout

func _on_timer_timeout():
	entered = true

func _on_area_2d_2_area_entered(area):
	if area.is_in_group("bullet") :
		# hakee damagen sen luodin skriptistä mikä siihen osui
		var gunDamage : float = area.get_parent().damage
		health = health - gunDamage
		healthBar._set_health(health)
		
		#print(area.global_position)
		#play_blood_animation(area.global_position)
		#
		if health <= 0 :
			get_node("Area2D/CollisionShape2D").queue_free() # poistaa hitboxin että luodit pääsee läpi
			get_node("Area2D2/CollisionShape2D").queue_free()
			self.set_physics_process(false)
			animation.play("die")
			await animation.animation_finished
			self.queue_free()
			
func _on_area_2d_body_entered(body):
	if body == player:
		# niin kauan kun pelaaja on lähempänä kuin 100 jotain ?, toistaa lyömis animaatiota
		while area2d.global_position.distance_to(player.global_position) <= 100 :
			# kääntää mobin pelaajaa päin, muuten saataisi jäädä huitomaan väärään suuntaan
			if player.global_position.x - self.global_position.x < 0 :
				animation.flip_h = false
			else : 
				animation.flip_h = true
			
			self.set_physics_process(false)
			# varmaan tähän väliin se koodi, joka vahingoitta pelaajaa eli hit_player.emit() ??? ja siihen jotain muokkausta
			# suorittaa pelaajan skriptistä funktion joka vähentää siltä elämää
			# vois ehkä käyttää signaaleja mutta ei ne varmaa ois parempia 
			animation.play("attack")
			await animation.animation_finished
			self.set_physics_process(true)
