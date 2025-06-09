extends Node2D

@export_range(1, 100) var weight_normal_platform: int = 90
@export var status_platform: bool = true
@export_enum("beige", "brown", "green", "gray", "pink", "white")
var color_platform: String = "pink"
@onready var scene_platforms_addons = preload("res://scenes/platforms_addons.tscn")

var top_percentage: int = 100
var initial_percentage: int = 1
var random: int = 0
var child_animated_sprite: String = "StaticBody2D/AnimatedSprite2D"
var animated_sprite: AnimatedSprite2D
var normal_platform: String = "normal"
var broken_platform: String = "broken"
var name_player_node: String = "CharacterBody2D"
var first_jump: bool = false
var node2d_platform_addon: Node2D
var dictionary_color: Dictionary = {
	"beige": 0, 
	"brown": 1, 
	"green": 2, 
	"gray": 3, 
	"pink": 4,
	"white": 5
}
var initial_index_addon: int = 1
var final_index_addon: int = 4
var dictionary_platform_addon: Dictionary = {
	1: {
		"name": "no_behavior",
		"positionY": -125,
		"positionX": [-160, 160],
	},
	2: {
		"name": "spikes",
		"positionY": -72,
		"positionX": [-130, 130],
	},
	3: {
		"name": "spring",
		"positionY": -100,
		"positionX": [-110, 110],
	},
	4: {
		"name": "spike",
		"positionY": -90,
		"positionX": [-150, 150],
	}
}
var weight_broken_platform: int = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random = randi_range(initial_percentage, top_percentage)
	animated_sprite = get_node(child_animated_sprite)
	
	if random <= weight_normal_platform:
		animated_sprite.animation = normal_platform
		status_platform = true
		if randi_range(initial_percentage, top_percentage) < 65:
			var str_platform_addon_name = dictionary_platform_addon[1]["name"]
			var int_platform_addon_position_y = dictionary_platform_addon[1]["positionY"]
			var int_platform_addon_position_x = randi_range(dictionary_platform_addon[1]["positionX"][0], dictionary_platform_addon[1]["positionX"][1])
			node2d_platform_addon = scene_platforms_addons.instantiate()
			node2d_platform_addon.addon = str_platform_addon_name
			node2d_platform_addon.global_position.y = node2d_platform_addon.global_position.y + int_platform_addon_position_y
			node2d_platform_addon.global_position.x = node2d_platform_addon.global_position.x + int_platform_addon_position_x
	else:
		if randi_range(1, 100) < weight_broken_platform:
			animated_sprite.animation = broken_platform
			status_platform = false
		else:
			status_platform = true
			random = randi_range(initial_index_addon + 1, final_index_addon) # + 1 porque excluimos las plataformas sin comportamienteo
			var str_platform_addon_name = dictionary_platform_addon[random]["name"]
			var int_platform_addon_position_y = dictionary_platform_addon[random]["positionY"]
			var int_platform_addon_position_x = randi_range(dictionary_platform_addon[random]["positionX"][0], dictionary_platform_addon[random]["positionX"][1])
			node2d_platform_addon = scene_platforms_addons.instantiate()
			node2d_platform_addon.addon = str_platform_addon_name
			node2d_platform_addon.global_position.y = node2d_platform_addon.global_position.y + int_platform_addon_position_y
			node2d_platform_addon.global_position.x = node2d_platform_addon.global_position.x + int_platform_addon_position_x
		
	animated_sprite.frame = dictionary_color[color_platform]
	add_child(node2d_platform_addon)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if animated_sprite.animation == broken_platform and first_jump and animated_sprite.animation != "smoke":
		animated_sprite.animation = "smoke"
		animated_sprite.scale = Vector2(6, 6)
		animated_sprite.play()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == name_player_node and body.is_falling and !first_jump: 
		body.collision_jump = true
		if animated_sprite.animation == broken_platform:
			first_jump = true # Las plataformas rotas solo pueden brincarse 1 vez
