from rethinkdb import RethinkDB
import subprocess

process = subprocess.Popen("rethinkdb", stdout=subprocess.PIPE)
output, error = process.communicate()

r = RethinkDB()

r.connect( "localhost", 28015).repl()

r.db("test").table_create("authors").run()

r.table("authors").insert([
    { "name": "William Adama", "tv_show": "Battlestar Galactica",
      "posts": [
        {"title": "Decommissioning speech", "content": "The Cylon War is long over..."},
        {"title": "We are at war", "content": "Moments ago, this ship received..."},
        {"title": "The new Earth", "content": "The discoveries of the past few days..."}
      ]
    },
    { "name": "Laura Roslin", "tv_show": "Battlestar Galactica",
      "posts": [
        {"title": "The oath of office", "content": "I, Laura Roslin, ..."},
        {"title": "They look like us", "content": "The Cylons have the ability..."}
      ]
    },
    { "name": "Jean-Luc Picard", "tv_show": "Star Trek TNG",
      "posts": [
        {"title": "Civil rights", "content": "There are some words I've known since..."}
      ]
    }
]).run()

process = subprocess.Popen("service rethinkdb stop", stdout=subprocess.PIPE)
output, error = process.communicate()
