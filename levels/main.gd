extends Node2D
class_name Main

@onready var paavopreload = preload("res://NPC/paavonpc.tscn")

var max_mobs : int

#käytetään jos on animoitavaa 
#@onready var anim = get_node("Player/GunNode/AnimatedSprite2D")

#tähän tulee sit hyökkäyslogiikkaa mut täl hetkel ei tee viel mitää muuta ku sano "moro"
func _on_enemyspawner_hit_p():
	print("moro :DDDDDDD")

func _ready() -> void:
	# asettaa itsensä Glogal.main muuttujaksi, että voi mistä tahansa skriptistä kutsua Global.main 
	# ase käyttää tätä, jolla se lisää sisar-nodena luodin Global.main.add_sibling(bullet)
	Global.main = self
	#oli 20 alunperin
	max_mobs = 10
	
	pass

#func _process(delta: float) -> void:
	#pass

# vaihtoehtoihen tapa siirtyä huoneiden välillä
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == Global.player:
		print("pelaaja tuli alueelle")
		var nextLevel = get_node("VASENALA/Doors/Door_E/Spawn").global_position
		Global.player.global_position = nextLevel
