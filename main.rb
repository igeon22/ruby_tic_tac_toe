class Board
  attr_accessor :board_state, :player1, :player2

  def initialize
    @board_state = Array.new(9, " ")
    @player1 = Player.new("O")
    @player2 = Player.new("X")
    self.setup_players
    self.game
  end

  def setup_players
    @player1.get_name
    @player2.get_name
  end

  def game
    marks = {
      @player1.mark => @player1.name,
      @player2.mark => @player2.name
    }

    self.print_board
    turn = 1
    while turn <= 9
      self.play_turn(turn)
      win = self.victory_check
      if win[0]
        puts "#{marks[win[1]]} is the winner!"
        break
      end
      turn += 1
    end

    puts "It's a draw!" if turn > 9 && !win[0]
  end

  def print_board
    puts "--------#{player1.name} vs #{player2.name}-------------"
    puts "#{board_state[0]} | #{board_state[1]} | #{board_state[2]}"
    puts "------------"
    puts "#{board_state[3]} | #{board_state[4]} | #{board_state[5]}"
    puts "------------"
    puts "#{board_state[6]} | #{board_state[7]} | #{board_state[8]}"
  end

  def victory_check
    win_conditions = [
      [0, 1, 2], # Horizontal top row
      [3, 4, 5], # Horizontal middle row
      [6, 7, 8], # Horizontal bottom row
      [0, 3, 6], # Vertical left column
      [1, 4, 7], # Vertical middle column
      [2, 5, 8], # Vertical right column
      [0, 4, 8], # Diagonal top-left to bottom-right
      [2, 4, 6]  # Diagonal top-right to bottom-left
    ]

    win_conditions.each do |condition|
      if board_state[condition[0]] != " " &&
         board_state[condition[0]] == board_state[condition[1]] &&
         board_state[condition[1]] == board_state[condition[2]]
        return [true, board_state[condition[0]]]
      end
    end

    [false, " "]
  end

  def play_turn(turn)
    current_player = turn.odd? ? @player1 : @player2
    puts "#{current_player.name}'s turn"
    player_choice = self.check_turn
    @board_state[player_choice] = current_player.mark
    self.print_board
  end

  def check_turn
    loop do
      print "Choose the number of the case you want (1-9): "
      choice = gets.chomp.to_i - 1
      if choice.between?(0, 8) && @board_state[choice] == " "
        return choice
      else
        puts "Invalid choice or space already taken. Try again."
      end
    end
  end
end

class Player
  attr_accessor :name, :mark

  def initialize(mark)
    @mark = mark
  end

  def get_name
    print "Player #{@mark}, enter your name: "
    @name = gets.chomp
  end
end

# Start a new game
new_game = Board.new
