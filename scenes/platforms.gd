extends Node2D

@export_range(1, 100) var weight_normal_platform: int = 90
@export var status_platform: bool = true
@export_enum("beige", "brown", "green", "gray", "pink", "white")
var color_platform: String = "pink"

var top_percentage: int = 100
var initial_percentage: int = 1
var random: int = 0
var child_animated_sprite: String = "StaticBody2D/AnimatedSprite2D"
var animated_sprite: AnimatedSprite2D
var normal_platform: String = "normal"
var broken_platform: String = "broken"
var name_player_node: String = "CharacterBody2D"
var first_jump: bool = false
var dictionary_color: Dictionary = {
	"beige": 0, 
	"brown": 1, 
	"green": 2, 
	"gray": 3, 
	"pink": 4,
	"white": 5
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random = randi_range(initial_percentage, top_percentage)
	animated_sprite = get_node(child_animated_sprite)
	
	if random <= weight_normal_platform:
		animated_sprite.animation = normal_platform
		status_platform = true
	else:
		animated_sprite.animation = broken_platform
		status_platform = false
		
	animated_sprite.frame = dictionary_color[color_platform]

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
