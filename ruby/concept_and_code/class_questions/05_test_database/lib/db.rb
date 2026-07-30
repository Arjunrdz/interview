require "sqlite3"

# db = SQLite3::Database.new("app.db") => this will create app.db file from the folder we call this file. If called from root, app.db will be created from root

db = SQLite3::Database.new(File.join(__dir__, "app.db"))

db.execute("CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE
)")

# db.execute("INSERT INTO users (name, email) VALUES (?, ?)", 
#   ["user1", "user1@gmail.com"]
# )

(1..100).each do |i|
  name = "user#{i}"
  email = "#{name}@gmail.com"
  db.execute("INSERT INTO users (name, email) VALUES (?, ?)", 
    [name, email]
  )
end

db.close


# module UserMangement
#   class DB
#     DEFUAULT_PATH File.expand_path("../../db/users.sqlite3")
#   end
# end