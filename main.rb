class Node
    attr_accessor :position, :parent, :children, :moves
    
    def initialize(position, parent = nil)
        @position = position
        @parent = parent
        @moves = [
            [1, 2],
            [2, 1],
            [2, -1],
            [1, -2],
            [-1, -2],
            [-2, -1],
            [-2, 1],
            [-1, 2],
        ]
        @children = get_children(@position, @moves)
    end

    def get_children(position, moves)
        children = []
        moves.each do |move|
            result = [(position[0] + move[0]), (position[1] + move[1])]
            if result.all? { |i| (0..7).include?(i) }
                children << result
            end
        end
        children
    end
end

class Game
    def initialize
        @board = make_board
    end

    def make_board
        board = []
        8.times do |index|
            row_index = index
            8.times do |index|
                position = []
                position.unshift(row_index)
                position << index
                board << position
            end
        end
        board
    end
end

def knight_moves(starting, ending)
    root = Node.new(starting)
    queue = [root]
    moves = 0
    path = []
    cur = nil
    until queue.empty?
        tmp = queue.shift
        if tmp.position == ending
            cur = tmp
            break
        end
        tmp.children.each do |position|
            node = Node.new position
            node.parent = tmp
            queue << node
        end
    end
    until cur.parent.nil?
        path.unshift(cur.position)
        cur = cur.parent
        moves += 1
    end
    path.unshift(starting)
    puts "The shortest path from #{starting} to #{ending} takes #{moves} moves."
    puts "Path:"
    puts "#{path}"
end

game = Game.new

knight_moves([1, 1], [1, 2])