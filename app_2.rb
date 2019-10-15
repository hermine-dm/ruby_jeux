require 'bundler'
require 'pry'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

puts "-----------------------------"
puts "| Etes vous prêts à jouer ? |"
puts "| Oui ? Alors c'est parti!  |"
puts "-----------------------------\n" #\n passsage à la ligne

puts "Salut, tu veux créer un jouer ? Commençons. Quel est ton prénom?"
print "> "
first_name = gets.chomp
user = HumanPlayer.new(first_name)
	
enemies = [] #introduction du array d'ennemis 
puts "\nSuper et maintenant : \nA ma droite Josiane"
player1 = Player.new("Josiane")
enemies.push(player1)
puts "A ma gauche José"
player2 = Player.new("José")
enemies.push(player2)

while user.life_points >0 && (player1.life_points > 0 || player2.life_points >0) #le jeu
	puts "\n> Voici l'état de chaque joueur :"
	player1.show_state
	player2.show_state
	user.show_state
	puts "\nQuelle action veux-tu effectuer ?\na - chercher une meilleure arme\ns - chercher à se soigner \nattaquer un joueur en vue :\n"
	if player1.life_points > (-1) then puts "0 - #{player1.name} a #{player1.life_points} points de vie\n" end
	if player2.life_points > (-1) then puts "1 - #{player2.name} a #{player2.life_points} points de vie\n" end
	print "> "
	choice_user = gets.chomp #l'utilisateur ecrit pour decouler les différentes possibilités
	if choice_user == "a" then user.search_weapon
	elsif choice_user == "s" then user.search_health_pack
	elsif choice_user == "0"
		puts "> FIGHT!"
		user.attacks(player1)
	elsif choice_user == "1"
		puts "> FIGHT!"
		user.attacks(player2)
	end
	puts "\nAttention le(s) ennemi(s) riposte(nt) :" #marche si l'ennemi a plus de 0 pts de vie
	enemies.each {|ennemi|if ennemi.life_points > 0 then ennemi.attacks(user) end}
end

unless user.life_points > 0 then puts "Loser tu as perdu"
else puts "Bravo tu as gagné"
end

#binding.pry