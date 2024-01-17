extends TextureRect

@onready var from_point : Control = $PointGradient2D1
@onready var to_point : Control = $PointGradient2D2

var gradient_texture_2d : GradientTexture2D

func _ready():
	from_point.position_changed.connect(_on_from_point_position_changed)
	to_point.position_changed.connect(_on_to_point_position_changed)

func clear() -> void:
	gradient_texture_2d = null
	texture.gradient = Gradient.new()
	
	var half_size : float = to_point.size.x / 2
	from_point.position = Vector2(-half_size, -half_size)
	to_point.position = Vector2(size.x - half_size, -half_size)
	
	texture.fill_from = Vector2(0, 0)
	texture.fill_to = Vector2(1, 0)

func set_gradient_text(value : GradientText) -> void:
	gradient_texture_2d = value.get_gradient_texture_2d()
	
	texture.gradient = gradient_texture_2d.get_gradient()
	
	texture.fill_from = gradient_texture_2d.fill_from
	texture.fill_to = gradient_texture_2d.fill_to
	
	from_point.position = gradient_texture_2d.fill_from * size - from_point.size / 2
	to_point.position = gradient_texture_2d.fill_to * size - to_point.size / 2
	
	set_fill(gradient_texture_2d.fill)

func set_fill(value : int) -> void:
	texture.fill = value

func _on_from_point_position_changed() -> void:
	if not gradient_texture_2d:
		return
	
	gradient_texture_2d.fill_from = (from_point.position + from_point.size / 2) / size
	texture.fill_from = gradient_texture_2d.fill_from

func _on_to_point_position_changed() -> void:
	if not gradient_texture_2d:
		return
	
	gradient_texture_2d.fill_to = (to_point.position + to_point.size / 2) / size
	texture.fill_to = gradient_texture_2d.fill_to
