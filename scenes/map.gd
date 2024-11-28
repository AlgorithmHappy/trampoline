extends Node2D

var window_size = Vector2(0, 0)
var platform_size = Vector2(0, 0)
var number_of_platforms: int = 0
@onready var scene_platform = preload("res://scenes/platforms.tscn")
var instances_platforms = []
var first_platform_index: int = 0
var animated_node_path: String = "StaticBody2D/AnimatedSprite2D"
var animation: String = "normal"
var main_frame: int = 0
var platforms_positions = {
	1: [
		Vector2((380/2), (1920 - (95/2))),
		Vector2((380/2) * 2, (1920 - (95/2))),
		Vector2((380/2) * 3, (1920 - (95/2))),
		Vector2((380/2) * 4, (1920 - (95/2))),
		Vector2((380/2) * 5, (1920 - (95/2)))
	],
	2: [
		Vector2((380/2), (1920 - (95/2)) - (95) * 2),
		Vector2((380/2) * 2, (1920 - (95/2)) - (95 * 2) ),
		Vector2((380/2) * 3, (1920 - (95/2)) - (95 * 2) ),
		Vector2((380/2) * 4, (1920 - (95/2)) - (95 * 2) ),
		Vector2((380/2) * 5, (1920 - (95/2)) - (95 * 2) )
	],
	3: [
		Vector2((380/2), (1920 - (95/2)) - (95 * 4) ),
		Vector2((380/2) * 2, (1920 - (95/2)) - (95 * 4) ),
		Vector2((380/2) * 3, (1920 - (95/2)) - (95 * 4) ),
		Vector2((380/2) * 4, (1920 - (95/2)) - (95 * 4) ),
		Vector2((380/2) * 5, (1920 - (95/2)) - (95 * 4) )
	],
	4: [
		Vector2((380/2), (1920 - (95/2)) - (95 * 6) ),
		Vector2((380/2) * 2, (1920 - (95/2)) - (95 * 6) ),
		Vector2((380/2) * 3, (1920 - (95/2)) - (95 * 6) ),
		Vector2((380/2) * 4, (1920 - (95/2)) - (95 * 6) ),
		Vector2((380/2) * 5, (1920 - (95/2)) - (95 * 6) )
	],
	5: [
		Vector2((380/2), (1920 - (95/2)) - (95 * 8) ),
		Vector2((380/2) * 2, (1920 - (95/2)) - (95 * 8) ),
		Vector2((380/2) * 3, (1920 - (95/2)) - (95 * 8) ),
		Vector2((380/2) * 4, (1920 - (95/2)) - (95 * 8) ),
		Vector2((380/2) * 5, (1920 - (95/2)) - (95 * 8) )
	],
	6: [
		Vector2((380/2), (1920 - (95/2)) - (95 * 10) ),
		Vector2((380/2) * 2, (1920 - (95/2)) - (95 * 10) ),
		Vector2((380/2) * 3, (1920 - (95/2)) - (95 * 10) ),
		Vector2((380/2) * 4, (1920 - (95/2)) - (95 * 10) ),
		Vector2((380/2) * 5, (1920 - (95/2)) - (95 * 10) )
	],
	7: [
		Vector2((380/2), (1920 - (95/2)) - (95 * 12) ),
		Vector2((380/2) * 2, (1920 - (95/2)) - (95 * 12) ),
		Vector2((380/2) * 3, (1920 - (95/2)) - (95 * 12) ),
		Vector2((380/2) * 4, (1920 - (95/2)) - (95 * 12) ),
		Vector2((380/2) * 5, (1920 - (95/2)) - (95 * 12) )
	],
	8: [
		Vector2((380/2), (1920 - (95/2)) - (95 * 14) ),
		Vector2((380/2) * 2, (1920 - (95/2)) - (95 * 14) ),
		Vector2((380/2) * 3, (1920 - (95/2)) - (95 * 14) ),
		Vector2((380/2) * 4, (1920 - (95/2)) - (95 * 14) ),
		Vector2((380/2) * 5, (1920 - (95/2)) - (95 * 14) )
	],
	9: [
		Vector2((380/2), (1920 - (95/2)) - (95 * 16) ),
		Vector2((380/2) * 2, (1920 - (95/2)) - (95 * 16) ),
		Vector2((380/2) * 3, (1920 - (95/2)) - (95 * 16) ),
		Vector2((380/2) * 4, (1920 - (95/2)) - (95 * 16) ),
		Vector2((380/2) * 5, (1920 - (95/2)) - (95 * 16) )
	],
	10: [
		Vector2((380/2), (1920 - (95/2)) - (95 * 18) ),
		Vector2((380/2) * 2, (1920 - (95/2)) - (95 * 18) ),
		Vector2((380/2) * 3, (1920 - (95/2)) - (95 * 18) ),
		Vector2((380/2) * 4, (1920 - (95/2)) - (95 * 18) ),
		Vector2((380/2) * 5, (1920 - (95/2)) - (95 * 18) )
	]
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_size = DisplayServer.window_get_size()
	instances_platforms.append(scene_platform.instantiate() )
	platform_size = instances_platforms[first_platform_index].get_node(animated_node_path).sprite_frames.get_frame_texture(animation, main_frame).get_size()
	number_of_platforms = window_size.y / platform_size.y
	instances_platforms[first_platform_index].position = Vector2(window_size.x/2 , window_size.y - (platform_size.y / 2) ) # En la posicion en medio y hasta abajo
	
	for iterator in range(1, 10):
		instances_platforms.append(scene_platform.instantiate())
		instances_platforms[iterator].position = platforms_positions[iterator + 1][randi_range(0, 4)]
	
	for item in instances_platforms:
		add_child(item)

	print(window_size)
	print(platform_size)
	print(number_of_platforms)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
