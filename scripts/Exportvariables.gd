# skripti suurin osa pelin komponenteista ottaa muuttujansa 
# esim. pelaajan nopeus, aseiden damage, tulinopeus jne. jne.
# ne on täällä että niitä voi helposti muokata Exportvariables noden inspectorista
# voi lisätä muitakin kuten aaltojen vihollisten määrä tai tulevien mobien damage, nopeus

@tool
extends Node2D

func _ready() -> void:
	Global.export = self
	
@export_group("Player")
@export var playerSpeed : int = 600
@export var playerHealth : int = 400 
@export var playerImmortal : bool = false

@export_group("Zombie")
@export var zombieHealth : int = 150
@export var zombieDamage : int = 20
@export var zombieSpeed : Array = [80, 120] # valitsee zombin nopeuden näiden kahden arvon väliltä

@export_group("Gun1")
@export var gun1Firerate : float = 700
@export var gun1BulletDamage : int = 14
@export var gun1BulletSpeed :int = 1500

@export_group("Gun2")
@export var gun2FireRate : float = 60
@export var gun2BulletDamage : int = 130
@export var gun2BulletSpeed : int = 3400
@export var gun2BulletAcceleration : int = 400

@export_group("Gun3")
@export var gun3FireRate : float = 500
@export var gun3BulletDamage : int = 1000

@export_group("Gun4")
@export var gun4FireRate : float = 80
@export var gun4BulletDamage : int = 40
@export var gun4BulletSpeed : Array = [1800, 2300]
@export var gun4Spread : int = 35
@export var gun4SpreadRandomness : float = 7
@export var gun4Pellets : int = 5
@export var gun4PelletDecay : float = 0.002
