extends LineEdit

var submitted: bool = false
var submitted_string: String = ""
var allowed_chars: Array[String] = ['a', 'b','c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's','t', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '_'];

func _ready() -> void:
	connect("text_submitted", submit_text)
	connect("text_changed", change_text)

func submit_text(string: String):
	submitted_string = string
	submitted = true
	release_focus()

func change_text(string: String):
	var col = caret_column
	var new_text = ""
	for i in string:
		if i in allowed_chars:
			new_text += i
	text = new_text
	caret_column = col
