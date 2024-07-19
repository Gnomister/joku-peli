extends ColorRect

class_name Typekenttä

@export var blue: Color = Color("#4682b4")
@export var green: Color = Color("#639765")
@export var red: Color = Color("#a65455")

@onready var prompt: RichTextLabel = $Typesana

func get_prompt() -> String:
	return prompt.text

func set_next_character(next_character_index: int):
	var text = prompt.text
	var blue_text = get_bbcode_color_tag(blue) + text.substr(0, next_character_index) + get_bbcode_end_color_tag()
	var green_text = ""
	var red_text = ""

	if next_character_index < text.length():
		green_text = get_bbcode_color_tag(green) + text.substr(next_character_index, 1) + get_bbcode_end_color_tag()
		if next_character_index + 1 < text.length():
			red_text = get_bbcode_color_tag(red) + text.substr(next_character_index + 1) + get_bbcode_end_color_tag()

	# Combine all parts ensuring BBCode is correctly applied
	var bbcode = "[center]" + blue_text + green_text + red_text + "[/center]"
	print("Blue text: %s" % blue_text)
	print("Green text: %s" % green_text)
	print("Red text: %s" % red_text)
	print("BBCode: %s" % bbcode)
	prompt.bbcode_text = bbcode

func get_bbcode_color_tag(color: Color) -> String:
	return "[color=" + color.to_html(false) + "]"
	
func get_bbcode_end_color_tag() -> String:
	return "[/color]"
