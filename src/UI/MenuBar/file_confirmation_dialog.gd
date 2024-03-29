extends ConfirmationDialog

@onready var path_file_dialog : FileDialog = $PathFileDialog

@onready var path : LineEdit = $PanelContainer/VBoxContainer/HBoxContainer/HBoxContainer/PathLineEdit
@onready var hq_styles : OptionButton = $PanelContainer/VBoxContainer/HBoxContainer2/StylesOptionButton
@onready var ia : CheckBox = $PanelContainer/VBoxContainer/HBoxContainer3/IACheckBox

func _ready():
	for key in Preference.hq_styles_string.keys():
		hq_styles.add_item(Preference.hq_styles_string[key], key)

func _on_confirmed():
	path.text = path.text.strip_edges()
	
	var dir_acess = DirAccess.open('.')
	
	if path.text.is_empty():
		Notification.message(tr('KEY_PATH_IS_EMPTY'))
		return
	
	if not dir_acess.dir_exists(path.text):
		Notification.message(tr('KEY_PATH_DONT_EXIST'))
		return
		
	FileHandler.open({
		'path': path.text,
		'style': hq_styles.selected,
		'ia': ia.button_pressed,
	})
	hide()

func _on_path_button_pressed():
	path_file_dialog.show()

func _on_path_file_dialog_dir_selected(dir):
	path.text = dir
