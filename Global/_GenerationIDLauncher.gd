class_name _GenerationIDLauncher
extends Node


var _alfabet_eng = 'abcdefghijklmnopqrstuvwxyz'

'''
rand_generate_word - рандомно генерирует буквы
'''
func rand_generate_word(chars, length):
	var word : String = ''
	var n_char = len(chars)
	for i in range(length):
		word += chars[randi()% n_char]
	return word


'''
generation_id - генерирует и возвращает уникальный id Launcher клиенту 
'''
func generation_id():
	return str(randi_range(100, 999)) + self.rand_generate_word(self._alfabet_eng, 3) + str(randi_range(1000, 9999)) + self.rand_generate_word(self._alfabet_eng, 2) + str(randi_range(10, 99)) + self.rand_generate_word(self._alfabet_eng, 5)
