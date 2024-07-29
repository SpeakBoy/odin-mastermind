require_relative "lib/codebreaker"
require_relative "lib/codemaker"

class Game
  def initialize
    @code_colors = ["red", "orange", "yellow", "green", "blue", "purple"]
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
        reset_variables
        game_finished = !(player_codebreaker)
      elsif input.upcase == "M"
        game_started = true
        reset_variables
        game_finished = !(player_codemaker)
      else
        puts "\nThat input is invalid. Please try again!"
        sleep(1)
        next
      end
    end
  end

  def reset_variables
    @guesses = []
    @responses = []
    @turns = 0
  end

  def read_rules
    reading_rules = true
    puts "\nThese are the rules! Type anything if you are finished reading and want to go back. (I don't feel like writing the rules for this.)"
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

  def player_codemaker
    player = Codemaker.new
    computer = Codebreaker.new
    player.code = player_codemaker_generate_code
    print player.code
    while @turns < 12
      @turns +=1
      player_codemaker_turn(@turns, player, computer)
      display_guesses_and_responses
      if check_for_codebreaker_win(@guesses.last, player.code) == true
        end_game("computer", "codemaker")
        break
      elsif @turns == 12
        end_game("player", "codemaker")
      end
    end
    decide_replay
  end

  def player_codemaker_turn(turn_number, player, computer)
    puts "\nTurn #{turn_number}:"
    guess = make_computer_guess
    @guesses.push(guess)
    response = player.check_guess(guess)
    @responses.push(response)
  end

  def player_codemaker_generate_code
    code = []
    while code.size < 4
      puts "\nPlease input your selection for Peg ##{code.size + 1} of 4."
      current_peg = gets.chomp
      if @code_colors.include?(current_peg)
        code.push(current_peg)
        puts "\nCurrent Code: #{code}"
      else
        puts "\nThat input is invalid. Please try again."
      end
    end
    code
  end

  def make_computer_guess
    code = []
    (0...4).each do
      code.push(@code_colors.sample)
    end
    code
  end

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
      else
        puts "\nCongratulations! The computer could not break your code!"
      end
    else
      if player_role == "codebreaker"
        puts "\nSorry, but you have failed to break the code in time! You lose!"
      else
        puts "\nSorry, but the computer managed to break your code! You lose!"
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
