extends Node2D

@onready var rootNode = get_tree().get_root().get_node('Game')

@onready var paavopreload = preload("res://paavonpc.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#rootNode.add_child(paavopreload.instantiate())
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
