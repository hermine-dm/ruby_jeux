require 'pry'

class Player
	attr_accessor :name
	attr_accessor :life_points

	def initialize(name)
		@name = name
		@life_points = 10
	end

	def show_state
		unless life_points > 0
			print self.name
			puts " est mort(e) avec #{life_points} point(s) de vie"
		else
			print self.name
			puts " a #{life_points} point(s) de vie"
		end
	end

	def gets_damage(number_of_damage)
		@life_points = @life_points - number_of_damage
		if @life_points <=0
			puts "#{self.name} a été tué !"
		end
	end

	def attacks(player)
		puts "#{self.name} attaque #{player.name}"
		number_rand_damage = compute_damage
		player.gets_damage(number_rand_damage)
		puts "il/elle lui inflige #{number_rand_damage} point(s) de dommages"
	end

	def compute_damage
    	return rand(1..6)
  	end

end

class HumanPlayer < Player #hierachie des class // à faire normalement sur une autre feuille
	attr_accessor :weapon_level

	def initialize(name)
		@name = name
		@life_points = 100 #j'ai modifié celle-ci
		@weapon_level = 1 # j'ai rajouté cette ligne
    	#super(name) #fait appel au initialize de la classe Player mais pour une ligne j'ai réécris
  	end

  	def show_state
		print self.name
		puts " a #{life_points} point(s) de vie et une arme de niveau #{weapon_level}"
	end

	def compute_damage
    	rand(1..6) * @weapon_level
  	end

  	def search_weapon
  		weapon_level_new = rand(1..6)
  		puts "Tu as trouvé une arme de niveau #{weapon_level_new}."
  		if weapon_level_new > @weapon_level
  			@weapon_level = weapon_level_new
  			puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
  		else puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
  		end
  	end

  	def search_health_pack 
  		dice = rand(1..6)
  		if dice == 1
  			puts "Tu n'as rien trouvé"
  		elsif dice > 1 && dice < 6
  			@life_points = @life_points + 50
  			puts "Bravo, tu as trouvé un pack de +50 points de vie !"
  		else 
  			@life_points = @life_points + 80
  			puts "Waow, tu as trouvé un pack de +80 points de vie"
  		end
  	end


end