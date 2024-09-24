class_name Json_file
extends Node


'''
check_argument_in_data_server - проверяет аргумент в данных сервера, с помощью цикла for.
'''
func check_argument_in_data_server(data , check_for_element_in_data : String , argument , type_return : int = 0):
	
	var status_check_id : bool
	var index_id : int = 0
	
	for elemet in data:
		
		index_id += 1
		
		if elemet[check_for_element_in_data] == argument:
			
			status_check_id = true
			
			break
			
		else:
			
			status_check_id = false
	
	if type_return == 0:
		
		return status_check_id
	
	elif type_return == 1:
		
		return index_id
		
	else:
		
		print('Не правильно введен тип возвращения данных в методе "check_argument_in_data_server"')
		
		return null


'''
write_and_return_read - читает файл или создает его, если нет. и возвращает его содержимое
write - изменять json файл
read - читать json файл и возвращает его содержимое
'''
func write_and_return_read_and_check_argument(path_data : String, append_json_data, check_for_element_in_data : String , argument , type_return : int = 0):
	
	var file_from_data = write_and_return_read( path_data , append_json_data )
	
	var index_from_file = check_argument_in_data_server(file_from_data , check_for_element_in_data, argument , type_return)
	
	return {'path' : path_data , 'file' : file_from_data , 'index' : index_from_file}

func write_and_return_read( append_path : String, append_json_data ):
	
	if not FileAccess.file_exists(append_path):
		
		print('Файл не существует: ', append_path)
		
		self.write( append_path , append_json_data )
	
	print('Файл существует: ', append_path)
	
	return read( append_path )

func write( append_path : String , append_json_data ):
	
	var file = FileAccess.open(append_path, FileAccess.WRITE)
		
	var json_string = JSON.stringify( append_json_data )
		
	file.store_line(json_string)

func read( append_path : String ):
	
	var file = FileAccess.open(append_path, FileAccess.READ)
	
	while file.get_position() < file.get_length():
	
		var json_string = file.get_line()
		var json = JSON.new()
		var _parse_result = json.parse(json_string)
		return json.get_data()

