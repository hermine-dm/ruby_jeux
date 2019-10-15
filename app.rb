require 'bundler'
require 'pry'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

puts "A ma droite Josiane"
player1 = Player.new("Josiane")
puts "A ma gauche José"
player2 = Player.new("José")
puts ""

while player1.life_points > 0 && player2.life_points > 0 #boucle jusqu'a ce qu'un est inf //egale à 0
	puts ""
	puts "> Voici l'état de chaque joueur :"
	player1.show_state
	player2.show_state
	puts ""
	puts "> FIGHT! Passons à la phase d'attaque :"
	puts "> Josiane aura l'honneur d'attaquer la première :"
	player1.attacks(player2)
		unless player2.life_points > 0
			break
		end
	puts "> José riposte :" #il y a pas cette ligne si José meurt en premier
	player2.attacks(player1)
end

#binding.pry