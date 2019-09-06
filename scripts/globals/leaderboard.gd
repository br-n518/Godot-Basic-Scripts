
const LEADERFILE:String = "user://data/terra_leaderboard"
const PASSWD:String = "kgo9GSg8Gj2snamzbapuiqy"
const LINE_DELIMITER:String = '`:=`'
const MAX_ENTRIES:int = 10

static func add_entry(username:String, score:int):
	if score > 0 and len(username) > 0:
		
		var d:Directory = Directory.new()
		if not d.dir_exists("user://data"):
			d.make_dir("user://data")
		
		var entries:Array = get_entries()
		var bytes:PoolByteArray = PoolByteArray()
		var line:PoolByteArray = ( username.strip_edges() + LINE_DELIMITER + str(score) + '\n' ).to_utf8()
		
		var i:int = 0
		for entry in entries:
			if i < MAX_ENTRIES and score > entry[1]:
				bytes.append_array(line)
				score = -1000 #prevent adding line twice
				i += 1
			# Check (i < MAX_ENTRIES) twice because it might have changed.
			if i < MAX_ENTRIES:
				bytes.append_array( entry[0].to_utf8())
				bytes.append_array( LINE_DELIMITER.to_utf8())
				bytes.append_array( (str(entry[1]) + '\n').to_utf8())
				i += 1
		if i < MAX_ENTRIES and score > 0:
			bytes.append_array(line)
		
		var f:File = File.new()
		f.open_encrypted_with_pass(LEADERFILE, File.WRITE, PASSWD)
		f.store_buffer(bytes)
		f.close()



# NOTE: Returns Array (not Dictionary) because the leaderboard is an ordered list.
static func get_entries() -> Array:
	var f:File = File.new()
	if f.file_exists(LEADERFILE):
		f.open_encrypted_with_pass(LEADERFILE, File.READ, PASSWD)
		var data:String = f.get_as_text()
		f.close()
		
		var s:Array = []
		for x in data.split('\n'):
			if len(x) > len(LINE_DELIMITER):
				x = x.split(LINE_DELIMITER)
				s.append( [ x[0], int(x[1]) ] )
		return s
	
	return []



# open file with mode File.WRITE in order to truncate the file.
# Password required to keep file accessible with password again later.
static func clear_entries():
	var f:File = File.new()
	f.open_encrypted_with_pass(LEADERFILE, File.WRITE, PASSWD)
	f.close()

