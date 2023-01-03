class Board
    attr_reader :grid
  
    def self.start_chess
      board = self.new
      8.times do |c|
        board[[1, c]] = Pawn.new(board, [1, c], :black)
        board[[6, c]] = Pawn.new(board, [6, c], :white)
      end
     
      [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook].each_with_index do |piece_klass, column|
        [[0, :black], [7, :white]].each do |(row, color)|
          location = [row, column]
          board[location] = piece_klass.new(
            board, 
            location,
            color
          )
        end
      end
  
      board
    end
  
    def initialize
      @grid = Array.new(8) { Array.new(8, NullPiece.instance) }
    end
  
    def []=(location, piece)
      row, column = location
      grid[row][column] = piece
    end
    
    def [](location)
      row, column = location
      grid[row][column]
    end
  
    def in_bounds?(location)
      row, column = location
  
      row < grid.length && 
        column < grid.first.length &&
        row >= 0 &&
        column >= 0
    end
  
    def empty?(location)
      row, column = location
      grid[row][column] == NullPiece.instance
    end
  
    def in_check?(color)
      king = pieces.find {|p| p.color == color && p.is_a?(King)}
        
      if king.nil?
        raise 'No king found.'
      end
  
      king_pos = king.location
  
      # loop over all the pieces of the opposite color
      pieces.select {|p| p.color != color }.each do |piece|
        # if any piece has an available move with the position