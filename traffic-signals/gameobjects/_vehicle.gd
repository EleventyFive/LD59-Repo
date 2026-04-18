extends Node2D
class_name Vehicle

@onready var sprite: Sprite2D = $Sprite2D
@onready var path: Path2D = $Path2D
@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D


func _ready() -> void:
	pass
	
