require_relative "lib/codebreaker"
require_relative "lib/codemaker"

class Game

  def initialize
    @guesses = []
    @responses = []
    @turns = 12
  end

  def start_new_game
    puts "Welcome to Mastermind! "
  end
end