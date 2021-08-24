extends Label

export (String, MULTILINE) var original_text = ""

func replace_text(new_text: Array):
	text = original_text % new_text
