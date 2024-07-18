require_relative "lib/codebreaker"
require_relative "lib/codemaker"

class Game
  def initialize
    @guesses = []
    @responses = []
    @turns = 0
  end

  def start_new_game
    game_started = false
    game_finished = false
    while game_started == false || game_finished == false
      puts "\nWelcome to Mastermind! A spectacular game of guessing!
      \nEnter R if you would like to read the rules!
      \nEnter B if you would like to play as the Codebreaker!
      \nEnter M if you would like to play as the Codemaker!"
      input = gets.chomp

      if input.upcase == "R"
        read_rules
      elsif input.upcase == "B"
        game_started = true
        game_finished = !(player_codebreaker)
      else
        puts "\nThat input is invalid. Please try again!"
        sleep(1)
        next
      end
    end
  end

  def read_rules
    reading_rules = true
    puts "\nThese are the rules! Type anything if you are finished reading and want to go back."
    while reading_rules == true
      input = gets.chomp
      unless input == nil
        reading_rules = false
      end
    end
  end

  def player_codebreaker
    player = Codebreaker.new
    computer = Codemaker.new
    computer.code = computer.generate_code
    while @turns < 12
      @turns += 1
      print "\n#{computer.code}"
      player_codebreaker_turn(@turns, player, computer)
      display_guesses_and_responses
      if check_for_codebreaker_win(@guesses.last, computer.code) == true
        end_game("player", "codebreaker")
        break
      elsif @turns == 12
        end_game("computer", "codebreaker")
      end
    end
    decide_replay
  end

  def player_codebreaker_turn(turn_number, player, computer)
    puts "\nTurn #{turn_number}:"
    guess = player.make_guess
    @guesses.push(guess)
    response = computer.check_guess(guess)
    @responses.push(response)
  end

  # def player_codemaker
  #   player = Codemaker.new
  #   computer = Codebreaker.new
  # end

  def display_guesses_and_responses
    @guesses.each_with_index do |guess, index|
      puts "\nTurn #{index + 1}:
      \nGuesses: #{guess.join(" ")}
      \nResponses: #{@responses[index].join(" ")}"
    end
  end

  def check_for_codebreaker_win(last_codebreaker_guess, codemaker_code)
    if last_codebreaker_guess == codemaker_code
      return true
    end
  end

  def end_game(winner, player_role)
    if winner == "player"
      if player_role == "codebreaker"
        puts "\nCongratulations! You broke the code!"
      end
    else
      if player_role == "codebreaker"
        puts "\nSorry, but you have failed to break the code in time! You lose!"
      end
    end
  end

  def decide_replay
    puts "\nWould you like to play again? (Y/N)"
    response = gets.chomp
    if response.upcase == "Y"
      return true
    end
    return false
  end
end

test = Game.new
test.start_new_game
