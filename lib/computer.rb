class Computer
  @@code_colors = ["red", "orange", "yellow", "green", "blue", "purple"]

  def initialize
    @code = nil
  end

  attr_accessor :code

  def generate_code
    code = []
    (0...4).each do
      code.push(@@code_colors.sample)
    end
    code
  end

  def check_guess(user_guess)
    guess_code = []
    user_guess_hash = Hash.new(0)
    3.times do |i|
      user_guess.each_with_index do |peg, index|
        if i == 0 && peg == @code[index]
          guess_code.push("red")
          user_guess_hash[peg] += 1
        elsif i == 1 && @code.include?(peg) && user_guess_hash[peg] < [user_guess.count(peg), @code.count(peg)].min
          guess_code.push("white")
          user_guess_hash[peg] += 1
        elsif i == 2 && guess_code.size < user_guess.size
          guess_code.push("none")
        end
      end
      print "#{user_guess_hash}, #{guess_code} \n"
    end
    guess_code.shuffle
  end
end