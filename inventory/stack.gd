class_name Stack

const uuid = preload('res://uuid.gd')

var id : String = uuid.v4()
var items : Array[Item] = [] # NOTE: imagine when true generics drop...

var max_size : int : get = get_max_size

func _init(new_items : Array[Item]):
	items = new_items

func get_max_size() -> int:
	if is_empty():
		return 0
	else:
		return items[0].stack

func size() -> int: # NOTE: not a property to be on par with Array
	return items.size()

func transfer_all(source : Stack) -> Stack:
	if is_matching_stack(source):
		while max_size - size() > 0 and not source.is_empty():
			push(source.pop())
	return source
	
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
