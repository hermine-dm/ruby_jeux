require 'pry'

class GameBis
	attr_accessor :human_player
	attr_accessor :enemies_in_sight #nb de joueurs atteignables
	attr_accessor :players_left #nb de joueurs restants



	def initialize(name)
		@enemies_in_sight = []
		@players_left = 10 #du coup en tout 14 ennemis en tout
		for i in 0..3
			@enemies_in_sight << Player.new("player#{i}")
		end
		@human_player = HumanPlayer.new(name)
		return @enemies_in_sight
	end

	def kill_player(player)
		@enemies_in_sight.delete_if{|enemi| enemi.name == player.name}
	end

	def is_still_ongoing?
		(@enemies_in_sight.size > 0 || players_left > 0) && @human_player.life_points > 0
	end

	def new_players_in_sight
		if @players_left < 1 #ils sont tous presents
			puts "ils sont tous sur le terrain"
		else
			dice_player = rand(1..6)
			if dice_player == 1
	  			puts "Aucun nouveau enemi arrive"
	  		elsif dice_player > 1 && dice_player < 5 
	  			@enemies_in_sight << Player.new("player#{rand(1..1000)}") 
	  			puts "1 nouvel enemi arrive"
	  			@players_left = @players_left - 1
	  		else #5 ou 6
	  			if @players_left > 1
	  				@enemies_in_sight << Player.new("player#{rand(1..1000)}") 
	  				@enemies_in_sight << Player.new("player#{rand(1..1000)}") 
	  				puts "Aie aie aie 2 nouveaux arrivent"
	  				@players_left = @players_left - 2
	  			else 
	  				@enemies_in_sight << Player.new("player#{rand(1..1000)}") 
	  				puts "1 nouvel enemi arrive"
	  				@players_left = @players_left - 1
	  			end
	  		end
	  	end
	  	return @players_left
  	end

	def show_players
		puts @human_player.show_state
		puts "il reste #{@enemies_in_sight.size} ennemi(s)"
	end

	def menu
		puts "\nQuelle action veux-tu effectuer ?\na - chercher une meilleure arme\ns - chercher à se soigner"
		puts "\nattaquer un joueur en vue :"
		for i in 0...@enemies_in_sight.size
			print "#{i} - "
			print @enemies_in_sight[i].show_state
		end
	end

	def menu_choice(choice_user)
		if choice_user == "a" then @human_player.search_weapon
		elsif choice_user == "s" then @human_player.search_health_pack
		else 
			for i in 0...@enemies_in_sight.size
				if choice_user.to_i == i
					puts "> FIGHT!"
					@human_player.attacks(@enemies_in_sight[i])
					if @enemies_in_sight[i].life_points <= 0 then kill_player(@enemies_in_sight[i]) end
				end
				
			end
		end
	end

	def enemies_attack
		puts "\n> Attention le(s) ennemi(s) riposte(nt) :"
		@enemies_in_sight.each {|ennemi| ennemi.attacks(@human_player)}
	end

	def end
		unless @human_player.life_points > 0 then puts "Loser tu as perdu"
		else puts "Bravo tu as gagné"
		end
	end

end