require 'bundler'
require 'pry'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/gamebis'

puts "-----------------------------"
puts "| Etes vous prêts à jouer ? |"
puts "| Oui ? Alors c'est parti!  |"
puts "-----------------------------\n" #\n passsage à la ligne

puts "Salut, tu veux créer un jouer ? Commençons. Quel est ton prénom?"
print "> "
first_name = gets.chomp
my_game = GameBis.new(first_name) #intialisation du jeu

while my_game.is_still_ongoing? == true
	puts "---"
	my_game.show_players #affiche les personnages restants
	puts "---"
	my_game.new_players_in_sight
	puts "---"
	my_game.menu #affiche le menu
	puts "Que veux tu faire ? reflechis bien.."
	print "> "
	choice = gets.chomp.to_s
	my_game.menu_choice(choice) #prend en compte le choix de l'utilisateur
	my_game.enemies_attack 
end

my_game.end

#binding.pry