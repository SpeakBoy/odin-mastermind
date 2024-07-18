class Codebreaker

  def initialize
    @code_colors = ["red", "orange", "yellow", "green", "blue", "purple"]
  end

  def make_guess
    guess = []
    while guess.size < 4
      puts "\nPlease select your guess for Peg #{guess.size + 1}"
      input = gets.chomp
      if @code_colors.include?(input.downcase)
        guess.push(input)
        puts "\nInput accepted."
      else
        puts "\nInvalid input detected. Please try again."
      end
      if guess.size == 4
        puts "\n#{guess} 
        \nAre you sure this is the guess you want? (Y/N)"
        input = gets.chomp
        unless input.upcase == "Y"
          guess = []
        end
      end
    end
    guess
  end
end