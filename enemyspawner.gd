extends Node2D

signal hit_p

var mob_scene := preload("res://NPC/mob.tscn")
var spawn_points := []

#spawnpointtien (Marker2D) määrittelyä
func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)
		
#aina kun timer menee nollaan niin vihollinen spawnaa randomisti valittuun spawnpointtiin ja jotai muutaki paskaa tapahtuu :D
func _on_timer_timeout():
	var mob_amount = get_tree().get_nodes_in_group("mob_amount")
	
	#jos mobeja on luotu enemmän ku maximi sallittu määrä niin ne lopettaa spawnaamasta
	if mob_amount.size() < get_parent().max_mobs:
		
	#randomisoi mihin spawnpointtiin mobi spawnaa
		var spawn = spawn_points[randi() % spawn_points.size()]
		var mob = mob_scene.instantiate()
		mob.position = spawn.position
	
	#hyökkäyslogiikkaa, en kyl ihan vittu itekkää ymmärrä mitä täs tapahtuu mut se toimii :D
		mob.hit_player.connect(hit)
	
		Global.main.add_child(mob)
	
	#lisää jokasen luodun mobin listaan että nähään montako mobia on luotu.
		mob.add_to_group("mob_amount")

#lisää hyökkäyslogiikkaa
func hit():
	hit_p.emit()
	print("hit()")
