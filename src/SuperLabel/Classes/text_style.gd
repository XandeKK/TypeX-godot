extends Node
class_name TextStyle

var parent : Control : set = _set_parent
var start : int  : get = _get_start, set = _set_start
var end : int : get = _get_end, set = _set_end
var bold : bool : get = _get_bold, set = _set_bold
var italic : bool : get = _get_italic, set = _set_italic
var font_size : int : get = _get_font_size, set = _set_font_size
var font_settings : Dictionary : get = _get_font_settings, set = _set_font_settings
var color : Color : get = _get_color, set = _set_color
var uppercase : bool : get = _get_uppercase, set = _set_uppercase
var outlines : Array : get = _get_outlines, set = _set_outlines
var shakes : Array : get = _get_shakes, set = _set_shakes

var outline_scene : PackedScene = load("res://src/SuperLabel/outline.tscn")
var shake_scene : PackedScene = load('res://src/SuperLabel/shake.tscn')

func remova_all() -> void:
	for i in outlines.size():
		remove_outline(0)
	
	for i in shakes.size():
		remove_shake(0)

func add_outline() -> void:
	var outline = outline_scene.instantiate()
	outline.start = start
	outline.end = end
	outline.is_global = false
	outline.z_index = 1
	outline.parent = parent
	parent.outlines.add_child(outline)
	
	outlines.append(outline)

func remove_outline(index : int) -> void:
	if index < 0 or index >= outlines.size():
		push_error('Unable to remove. Index is out of range')
		return
	
	var outline : Control = outlines[index]
	
	parent.outlines.remove_child(outline)
	outlines.remove_at(index)
	
	outline.queue_free()

func add_shake() -> void:
	var shake = shake_scene.instantiate()
	shake.start = start
	shake.end = end
	shake.is_global = false
	shake.parent = parent
	parent.shakes.add_child(shake)
	
	shakes.append(shake)

func remove_shake(index : int) -> void:
	if index < 0 or index >= shakes.size():
		push_error('Unable to remove. Index is out of range')
		return
	
	var shake : Control = shakes[index]
	
	parent.shakes.remove_child(shake)
	shakes.remove_at(index)
	
	shake.queue_free()

func _set_parent(value : Control) -> void:
	parent = value

func _get_start() -> int:
	return start

func _set_start(value : int) -> void:
	start = value
	for outline in outlines:
		outline.start = start
	
	for shake in shakes:
		shake.start = start
	
	parent._shape()

func _get_end() -> int:
	return end

func _set_end(value : int) -> void:
	end = value
	for outline in outlines:
		outline.end = end
	
	for shake in shakes:
		shake.end = end
	
	parent._shape()

func _get_bold() -> bool:
	return bold

func _set_bold(value : bool) -> void:
	bold = value
	parent._shape()

func _get_italic() -> bool:
	return italic

func _set_italic(value : bool) -> void:
	italic = value
	parent._shape()

func _get_font_size() -> int:
	return font_size

func _set_font_size(value : int) -> void:
	font_size = value
	parent._shape()

func _get_font_settings() -> Dictionary:
	return font_settings

func _set_font_settings(value : Dictionary) -> void:
	font_settings = value.duplicate()
	parent._shape()

func _get_color() -> Color:
	return color

func _set_color(value : Color) -> void:
	color = value
	parent._shape()

func _get_uppercase() -> bool:
	return uppercase

func _set_uppercase(value : bool) -> void:
	uppercase = value
	parent._shape()

func _get_outlines() -> Array:
	return outlines

func _set_outlines(value : Array) ->  void:
	outlines = value.duplicate()

func _get_shakes() -> Array:
	return shakes

func _set_shakes(value : Array) -> void:
	shakes = value.duplicate()
