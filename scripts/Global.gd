extends Node2D

@onready var main : Main
@onready var player : Player 
@onready var export : Node2D
var camera

var paused : bool = false

var room1Entered : bool = false
var room1Cleared : bool = false
var room2Entered : bool = false
var room2Cleared : bool = false
var room3Entered : bool = false
var room3Cleared : bool = false

func _summon_buff(pos : Vector2, type : String ):
	match type:
		"health":
			var healthBottle = export.healthBottleScene.instantiate()
			healthBottle.global_position = pos
			Global.main.add_sibling(healthBottle)
			
		_:
			print("Väärä tyyppi", type)
		
