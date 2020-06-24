class Pokemon
	attr_accessor :id, :name, :type, :db
	def initialize(id:, name:, type:, db:)
		@id = id
		@name = name
		@type = type
		@db = db
	end

	def self.save(name,type,db)
		new_pokemon = self.new(id: nil, name: name, type: type, db: db)
		sql = "INSERT INTO pokemon (name, type) VALUES (?, ?);"
		new_pokemon.db.execute(sql, name, type)
		new_pokemon.id = new_pokemon.db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
		new_pokemon
	end

	def self.find(id, db)
		sql = "SELECT * FROM pokemon WHERE id = ?"
		poke_row = db.execute(sql, id)[0]
		self.new(id: id, name: poke_row[1], type: poke_row[2], db: db)
	end
end
