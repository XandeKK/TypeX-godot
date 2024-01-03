extends PanelContainer

@export var file_dialog : FileDialog

@onready var dir_line_edit : LineEdit = $VBoxContainer/HBoxContainer/DirLineEdit
@onready var item_list : ItemList = $VBoxContainer/ItemList

var selected_item : int = -1

func _ready() -> void:
	FontConfigManager.dirs_changed.connect(_on_dir_changed)
	_on_dir_changed()

func _on_open_button_pressed() -> void:
	file_dialog.show()

func _on_dir_file_dialog_dir_selected(dir) -> void:
	dir_line_edit.text = dir

func _on_add_button_pressed():
	if dir_line_edit.text.is_empty():
		return
	FontConfigManager.add_dir(dir_line_edit.text)
	dir_line_edit.text = ''
	FontConfigManager.save_configuration()

func _on_remove_button_pressed():
	if selected_item != -1:
		FontConfigManager.remove_dir(selected_item)
		selected_item = -1
	FontConfigManager.save_configuration()

func _on_item_list_item_selected(index):
	selected_item = index

func _on_dir_changed() -> void:
	selected_item = 0
	item_list.clear()
	for dir in FontConfigManager.dirs:
		item_list.add_item(dir)
