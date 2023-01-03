class Bishop < Piece 
    include slideable

    def to_s
        color == :black ? "♝" : "♗"
      end
    
      def move_dirs
        [
          [1, 1],
          [1, -1],
          [-1, 1],
          [-1, -1],
        ]
      end
    end