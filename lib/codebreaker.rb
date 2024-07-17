class Codebreaker
  @code_colors = ["red", "orange", "yellow", "green", "blue", "purple"]

  def initialize
    @code_colors = ["red", "orange", "yellow", "green", "blue", "purple"]
    @guesses = []
  end

  def make_guess(pegs_guessed)
    @guesses.push(pegs_guessed)
    @guesses.last
  end
end