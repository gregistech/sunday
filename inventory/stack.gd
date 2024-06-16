class_name Stack

const uuid = preload('res://uuid.gd')

var id : String = uuid.v4()
var items : Array[Item] = [] # NOTE: imagine when true generics drop...

var max_size : int : get = _get_max_size
var weight : int : get = _get_weight

var texture : Texture2D : get = _get_texture
var main_item : Item : get = _get_main_item

func _get_main_item() -> Item:
	if not items.is_empty():
		return items[0]
	return null

func _get_texture() -> Texture2D:
	var item := main_item
	if main_item != null:
		return item.texture
	return null

func _init(new_items : Array[Item]):
	items = new_items

func _get_weight() -> int:
	var result := 0
	for item in items:
		result += item.weight
	return result

func _get_max_size() -> int:
	if is_empty():
		return 0
	else:
		return items[0].stack

func size() -> int: # NOTE: not a property to be on par with Array
	return items.size()

func transfer(source : Stack, amount : int) -> Stack:
	# NOTE: bootstrap stack if it was empty beforehand, 
	# this signals to me my system could use improvements...
	if is_empty(): 
		if amount > 0 and source.size() > 0:
			push(source.pop())
			amount -= 1
		else:
			return source
	if is_matching_stack(source) and amount > 0:
		while max_size - size() > 0 and amount > 0 and not source.is_empty():
			push(source.pop())
			amount -= 1
	return source

func transfer_all(source : Stack) -> Stack:
	return transfer(source, source.size())
	
func is_matching_stack(stack : Stack) -> bool:
	if not stack.is_empty() and not is_empty():
		return stack.items[0].id == items[0].id
	return false

func is_empty() -> bool:
	return items.is_empty()

func push(item : Item) -> bool:
	if item != null:
		if items.size() < item.stack:
			if items.size() > 0:
				if items[0].id != item.id:
					return false
			items.push_back(item)
			return true
		else:
			return false
	else:
		return false
	
func pop() -> Item:
	return items.pop_back()
