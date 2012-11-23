class DB
	require "mysql"
	@@db
	
	def self.Get
		return @@db
	end
	
	def self.Connect
		@@db = Mysql.init
		@@db.options(Mysql::SET_CHARSET_NAME, 'utf8')
		@@db.real_connect('198.175.125.69', 'foodl', 'foodl4321', 'foodl')
		@@db.query("SET NAMES utf8")
	end
end #end of class