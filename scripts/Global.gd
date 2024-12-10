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

var room4Entered : bool = false
var room4Cleared : bool = false

var room5Entered : bool = false
var room5Cleared : bool = false

var room6Entered : bool = false
var room6Cleared : bool = false

var room7Entered : bool = false
var room7Cleared : bool = false

var room8Entered : bool = false
var room8Cleared : bool = false

var gun2Unlocked : bool = false
var gun3Unlocked : bool = false

func _summon_buff(pos : Vector2, type : String ):
	match type:
		"health":
			var healthBottle = export.healthBottleScene.instantiate()
			healthBottle.global_position = pos
			Global.main.add_sibling(healthBottle)
			
		_:
			print("Väärä tyyppi", type)
		
