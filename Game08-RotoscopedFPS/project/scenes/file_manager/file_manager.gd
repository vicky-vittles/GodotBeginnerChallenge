extends Node
class_name FileManager

func save_file(file_name, object):
	var file = File.new()
	file.open(file_name, File.WRITE)
	file.store_var(object)
	file.close()

func load_file(file_name):
	var object = null
	var file = File.new()
	if file.file_exists(file_name):
		file.open(file_name, File.READ)
		object = file.get_var()
		file.close()
	return object
