extends Node2D

@export_enum("no_behavior", "spikes", "spring", "spike")
var addon: String = "spring"
@onready var addons: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D

var collision: CollisionShape2D
var min_index_frame_no_behavior: int = 0
var max_index_frame_no_behavior: int = 6
var start_frame_spring: int = 0
var name_player_node: String = "CharacterBody2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	addons.animation = addon
	match addon:
		"no_behavior":
			addons.frame = randi_range(min_index_frame_no_behavior, max_index_frame_no_behavior)
		"spikes":
			collision = $Area2D/CollisionShape2DSpikes
		"spike":
			collision = $Area2D/CollisionShape2DSpike
		"spring":
			collision = $Area2D/CollisionShapeSpring
			addons.frame = start_frame_spring


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_instance_valid(collision):
		if collision.name == "CollisionShapeSpring":
			if body.name == name_player_node and body.is_falling: 
				body.collision_jump = true
				body.plus_jump = 50000
				addons.play("spring")
