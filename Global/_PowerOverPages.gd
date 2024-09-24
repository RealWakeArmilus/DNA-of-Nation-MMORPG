extends Node


var pages_for_windows = { 
	'JoinInAccount' : { 'Close' : 'JoinInAccount' , 'Open' : 'res://Pages/Windows/Form/JoinInAccount.tscn' },
	'Loading' : { 'Close' : 'Loading' , 'Open' : "res://Pages/Windows/loading/Loading.tscn" },
	'PersonalAccount' : { 'Close' : 'PersonalAccount' , 'Open' : "res://Pages/Windows/Personal account/PersonalAccount.tscn" },
	
	'Server_connection_failed' : { 'Close' : 'Server_connection_failed' , 'Open' : "res://Page/tscn/server_connection_failed.tscn" },
	'Server_under_maintenance' : { 'Close' : 'Server_under_maintenance' , 'Open' : "res://Page/tscn/server_under_maintenance.tscn" },
	'Setting_server' : { 'Close' : 'Setting_server' , 'Open' : "res://Page/tscn/setting_server.tscn" },
	}




func open_close_for_windows(page_open : String , page_close : String):
	
	if page_close == 'Loading':
		
		await get_tree().create_timer(10).timeout
	
	open_for_windows(page_open)
	close_for_windows(page_close)

func open_for_windows(append_page : String):
	
	print('Открыть для Windows: ', append_page)
	
	get_node('/root/Page/Windows').add_child(load(pages_for_windows[append_page]['Open']).instantiate()) # format "res://derictory/Name_file.tscn"

func close_for_windows(append_page : String):
	
	print('Закрыть для Windows: ', append_page)
	
	get_node('/root/Page/Windows').get_node(pages_for_windows[append_page]['Close']).queue_free() # format 'NamePage'
