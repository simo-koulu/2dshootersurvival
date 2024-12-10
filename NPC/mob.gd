extends CharacterBody2D

@onready var player = Global.player
@onready var animation = $AnimatedSprite2D
@onready var bloodAnim = $Bloodanimation
@onready var area2d = get_node("Area2D")
@onready var healthBar = get_node("Healthbar")
@onready var roomCenter = get_parent().get_parent().get_node("PlayerDetectorArea/PlayerDetector")
var entered : bool = false
var direction : Vector2

# nämä arvot tulee spawnerilta kun mobi spawnaa
var health : int
var damage : int
var speed : int 

func play_blood_animation (location) :
	bloodAnim.position = location
	bloodAnim.visible = true
	bloodAnim.play("hit")
	await bloodAnim.animation_finished
	bloodAnim.visible = false
	
func _ready():
	direction = roomCenter.global_position - global_position
	animation.flip_h = direction.x < 0
	healthBar._init_bar(health)

#kun mobi on kentän sisällä ja juoksu sen vähän aikaa nii sit se alkaa jahtaa pelaajaa
func _physics_process(delta):
	if entered:
		animation.play("run")
		direction = (player.global_position - global_position).normalized()
		direction = direction.normalized()
		#velocity = (direction * speed)
		move_and_collide(direction * speed * delta)
		
		#kääntää animaation riippuen mobin kulkusuunnasta
		animation.flip_h = direction.x < 0

	while area2d.global_position.distance_to(player.global_position) <= 100 and entered :
			# kääntää mobin pelaajaa päin, muuten saataisi jäädä huitomaan väärään suuntaan
			if player.global_position.x - self.global_position.x < 0 :
				animation.flip_h = true
			else : 
				animation.flip_h = false
			
			self.set_physics_process(false)
			# varmaan tähän väliin se koodi, joka vahingoitta pelaajaa eli hit_player.emit() ??? ja siihen jotain muokkausta
			# suorittaa pelaajan skriptistä funktion joka vähentää siltä elämää
			# vois ehkä käyttää signaaleja mutta ei ne varmaa ois parempia 
			player._got_hit(damage)
			animation.play("attack")
			await animation.animation_finished
			self.set_physics_process(true)

func _on_entrancetimer_timeout():
	entered = true

func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet") :
		# hakee damagen sen luodin skriptistä mikä siihen osui
		var gunDamage : int = area.get_parent().damage
		health = health - gunDamage
		healthBar._set_health(health)
		
		#print(area.global_position)
		#play_blood_animation(area.global_position)
		#
		if health <= 0 :
			get_node("Area2D/CollisionShape2D2").queue_free() # poistaa hitboxin että luodit pääsee läpi
			self.set_physics_process(false)
			animation.play("die")
			await animation.animation_finished
			self.queue_free()
			if randi_range(0, 100) <= 10 :
				Global._summon_buff(self.global_position, "health")
			#enemies_dead.append(1)
	
#Kun pelaaja osuu viholliseen ni se triggeröi lyöntianimaation ja pysähtyy
func _on_area_2d_body_entered(body):
	if body == player:
		# niin kauan kun pelaaja on lähempänä kuin 100 jotain ?, toistaa lyömis animaatiota
		while area2d.global_position.distance_to(player.global_position) <= 100 :
			# kääntää mobin pelaajaa päin, muuten saataisi jäädä huitomaan väärään suuntaan
			if player.global_position.x - self.global_position.x < 0 :
				animation.flip_h = true
			else : 
				animation.flip_h = false
			
			self.set_physics_process(false)
			# varmaan tähän väliin se koodi, joka vahingoitta pelaajaa eli hit_player.emit() ??? ja siihen jotain muokkausta
			# suorittaa pelaajan skriptistä funktion joka vähentää siltä elämää
			# vois ehkä käyttää signaaleja mutta ei ne varmaa ois parempia 
			player._got_hit(damage)
			animation.play("attack")
			await animation.animation_finished
			self.set_physics_process(true)
