require 'pry'

class Game
	attr_accessor :human_player
	attr_accessor :enemies #nb de joueurs atteignables



	def initialize(name)
		@enemies = []
		@players_left = 10
		for i in 0..3
			@enemies << Player.new("player#{i}") 
		end
		@human_player = HumanPlayer.new(name)
		return @enemies
	end

	def kill_player(player)
		@enemies.delete_if{|enemi| enemi.name == player.name}
	end

	def is_still_ongoing?
		@enemies.size > 0 && @human_player.life_points > 0
	end

	def show_players
		puts @human_player.show_state
		puts "il reste #{@enemies.size} ennemi(s)"
	end

	def menu
		puts "\nQuelle action veux-tu effectuer ?\na - chercher une meilleure arme\ns - chercher à se soigner"
		puts "\nattaquer un joueur en vue :"
		for i in 0...@enemies.size
			print "#{i} - "
			print @enemies[i].show_state
		end
	end

	def menu_choice(choice_user)
		if choice_user == "a" then @human_player.search_weapon
		elsif choice_user == "s" then @human_player.search_health_pack
		else 
			for i in 0...@enemies.size
				if choice_user.to_i == i
					puts "> FIGHT!"
					@human_player.attacks(@enemies[i])
					if @enemies[i].life_points <= 0 then kill_player(@enemies[i]) end
				end
				
			end
		end
	end

	def enemies_attack
		puts "\n> Attention le(s) ennemi(s) riposte(nt) :"
		@enemies.each {|ennemi| ennemi.attacks(@human_player)}
	end

	def end
		unless @human_player.life_points > 0 then puts "Loser tu as perdu"
		else puts "Bravo tu as gagné"
		end
	end

end