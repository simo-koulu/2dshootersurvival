extends Node2D

#signal hit_p

var mobs_created = []
var mob_scene := preload("res://NPC/mob.tscn")
var spawn_points := []
var enemies_died = []
var waves_cleared = []
@onready var timer = get_node("Timer")
var wait_time : float = 1.8
@onready var wave_timer = get_node("wave_pause")
#spawnpointtien (Marker2D) määrittelyä
func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

#aina kun timer menee nollaan niin vihollinen spawnaa randomisti valittuun spawnpointtiin ja jotai muutaki paskaa tapahtuu :D
func _on_timer_timeout():
	var mob_amount = get_tree().get_nodes_in_group("mob_amount")
	
	#jos mobeja on luotu enemmän ku maximi sallittu määrä niin ne lopettaa spawnaamasta
	if enemies_died.size() < get_parent().max_mobs:
		
	#randomisoi mihin spawnpointtiin mobi spawnaa
		var spawn = spawn_points[randi() % spawn_points.size()]
		var mob = mob_scene.instantiate()
		mob.global_position = spawn.global_position

	
		Global.main.add_child(mob)
	
	#lisää jokasen luodun mobin listaan että nähään montako mobia on luotu.
		mob.add_to_group("mob_amount")
		mobs_created.append(1)
		
		#sitku kaikki viholliset on tapettu nii uus wave alkaa
	elif mobs_created.size() == enemies_died.size():
		mobs_created.clear()
		#pieni paussi wavejen välissä (voi säätää)
		wave_timer.start()
		await wave_timer.timeout
		print("next wave begins")
		
		#aina kun yks wave on alkanu se lisää sen listaan mistä voi tarkastaa montako wavea on ollu
		waves_cleared.append(1)
		
		#jos alkaneiden wavejen määrä on alle 5 nii sit alkaa aina uus wave jossa zombien spawnausaika puolittuu. 
		if waves_cleared.size() < 10: #  <--------- tost voi säätää montako wavee tapahtuu
			enemies_died.clear()
			if wait_time >= 0.2 :
				wait_time = wait_time / 2 # <------------ tost voi säätää et kuinka paljon se zombien..
		#.. spawnausaika tihenee joka kerta ku uus wave alkaa. Täl hetkel jakaa sen aina kahella
			timer.set_wait_time(wait_time)
