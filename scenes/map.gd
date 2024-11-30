extends Node2D

var window_size = Vector2(0, 0)
var platform_size = Vector2(0, 0)
var number_of_platforms: int = 0
@onready var scene_platform = preload("res://scenes/platforms.tscn")
var instances_platforms = [] # Actuara como una cola
var first_platform_index: int = 0
var animated_node_path: String = "StaticBody2D/AnimatedSprite2D"
var animation: String = "normal"
var main_frame: int = 0
var path_player_node: String = "Bunny/CharacterBody2D"
var path_background_node: String = "Background/ParallaxBackground"
var weight_normal_platform: int = 90
var platforms_colors = { # "beige", "brown", "green", "gray", "pink", "white"
	1: "beige",
	2: "brown",
	3: "green",
	4: "gray",
	5: "pink",
	6: "white"
}
var player: Node2D
var move_bunny_apply = Vector2(0, 0)
var min_y_position_camera: int = (1920/3) * 2 # Tamaño de alto de la ventana
@onready var camera: Camera2D = $Camera2D
var new_platform_position = Vector2(0, 0)
var background_layers: ParallaxBackground
var platform_spacing: float = 1
var platforms_positions = {
	1: [ # Plataforma de mas abajo
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
	10: [ # Plataforma de mas arriba
		Vector2((380/2), (1920 - (95/2)) - (95 * 18) ),
		Vector2((380/2) * 2, (1920 - (95/2)) - (95 * 18) ),
		Vector2((380/2) * 3, (1920 - (95/2)) - (95 * 18) ),
		Vector2((380/2) * 4, (1920 - (95/2)) - (95 * 18) ),
		Vector2((380/2) * 5, (1920 - (95/2)) - (95 * 18) )
	],
	11: [ # Plataforma de mas arriba
		Vector2((380/2), (1920 - (95/2)) - (95 * 20) ),
		Vector2((380/2) * 2, (1920 - (95/2)) - (95 * 20) ),
		Vector2((380/2) * 3, (1920 - (95/2)) - (95 * 20) ),
		Vector2((380/2) * 4, (1920 - (95/2)) - (95 * 20) ),
		Vector2((380/2) * 5, (1920 - (95/2)) - (95 * 20) )
	],
	12: [ # Plataforma de mas arriba
		Vector2((380/2), (1920 - (95/2)) - (95 * 22) ),
		Vector2((380/2) * 2, (1920 - (95/2)) - (95 * 22) ),
		Vector2((380/2) * 3, (1920 - (95/2)) - (95 * 22) ),
		Vector2((380/2) * 4, (1920 - (95/2)) - (95 * 22) ),
		Vector2((380/2) * 5, (1920 - (95/2)) - (95 * 22) )
	]
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_size = DisplayServer.window_get_size()
	instances_platforms.push_back(scene_platform.instantiate() )
	platform_size = instances_platforms[first_platform_index].get_node(animated_node_path).sprite_frames.get_frame_texture(animation, main_frame).get_size()
	number_of_platforms = window_size.y / platform_size.y
	instances_platforms[first_platform_index].position = Vector2(window_size.x/2 , window_size.y - (platform_size.y / 2) ) # En la posicion en medio y hasta abajo
	add_child(instances_platforms[first_platform_index])
	
	for iterator in range(1, 12):
		instances_platforms.push_back(scene_platform.instantiate())
		instances_platforms[iterator].position = platforms_positions[iterator + 1][randi_range(0, 4)]
		instances_platforms[iterator].color_platform = platforms_colors[randi_range(1, 6)]
		add_child(instances_platforms[iterator])
		
	player = get_node(path_player_node)
	background_layers = get_node(path_background_node)
		
	camera.global_position.y = player.global_position.y
	
	new_platform_position = platforms_positions[12][randi_range(0, 4)]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if min_y_position_camera > player.global_position.y:
		camera.global_position.y = player.global_position.y
		min_y_position_camera = camera.global_position.y
	
	background_layers.offset.y = camera.global_position.y	
	
	if player.move_bunny.y < 0: # El conejo sobrepaso el primer tercio de la pantalla (true = si | false = no)
		if player.move_bunny.y < move_bunny_apply.y: # Falta por aplicar los pixeles que sobrepaso el conejo en las plataformas (true = si | false = no)
			for iterator in instances_platforms:
				iterator.position.y += ( (player.move_bunny.y + (move_bunny_apply.y * -1) ) * -1) # Se aplican los pixeles que faltan para mover las plataformas hacia abajo
			move_bunny_apply.y += player.move_bunny.y + (move_bunny_apply.y * -1) # Se guarda en esta variable los pixeles aplicados hacia abajo
		
	if move_bunny_apply.y <= new_platform_position.y:
		instances_platforms.push_back(scene_platform.instantiate() )
		instances_platforms[instances_platforms.size() - 1].position = new_platform_position
		instances_platforms[instances_platforms.size() - 1].color_platform = platforms_colors[randi_range(1, 6)]
		instances_platforms[instances_platforms.size() - 1].weight_normal_platform = weight_normal_platform
		add_child(instances_platforms[instances_platforms.size() - 1])
		new_platform_position = Vector2(( (380/2) * randi_range(1, 5) ), new_platform_position.y - (95*platform_spacing) )
		var platform_to_delete = instances_platforms.pop_front()
		platform_to_delete.queue_free()
	
func _on_timer_timeout() -> void:
	platform_spacing += 0.5
	if platform_spacing >= 2.5:
		platform_spacing = 2.5


func _on_timer_2_timeout() -> void:
	weight_normal_platform = weight_normal_platform - 20
	if weight_normal_platform <= 10:
		weight_normal_platform = 10
