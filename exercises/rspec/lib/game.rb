require 'pry'

class Game

  COMBINATIONS = { :rock => :scissors, :scissors => :paper, :paper => :rock }

  def winner(player1_choice, player2_choice)
    return :player1 if COMBINATIONS[player1_choice] == player2_choice
    return :player2 if COMBINATIONS[player2_choice] == player1_choice
    :draw
  end

  def get_users_weapon
    puts 'Pick your weapon...'
    gets.chomp.to_sym
  end

  def get_computers_weapon
    COMBINATIONS.values.sample
  end

  def play

    case winner(get_users_weapon, get_computers_weapon)
      when :player1 then puts "You win, woohoo"
      when :player2 then puts "Loser, the computer won"
      else puts "It's a draw!"
    end

  end

end