class Node
    attr_accessor :position, :parent, :children
    
    def initialize position, parent = nil
        @position = position
        @parent = parent
        @children = get_children position
    end

    def get_children position
        children = []

        children << [position[0] + 1, position[1] + 2] unless position[0] == 7 || position[1] >= 6
        children << [position[0] + 2, position[1] + 1] unless position[0] >= 6 || position[1] == 7
        children << [position[0] + 2, position[1] - 1] unless position[0] >= 6 || position[1] == 0
        children << [position[0] + 1, position[1] - 2] unless position[0] == 7 || position[1] <= 1
        children << [position[0] - 1, position[1] - 2] unless position[0] == 0 || position[1] <= 1
        children << [position[0] - 2, position[1] - 1] unless position[0] <= 1 || position[1] == 0
        children << [position[0] - 2, position[1] + 1] unless position[0] <= 1 || position[1] == 7
        children << [position[0] - 1, position[1] + 2] unless position[0] == 0 || position[1] >= 6

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
                position.unshift row_index
                position << index
                board << position
            end
        end
        board
    end
end

def knight_moves starting, ending
    root = Node.new starting
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
        path.unshift cur.position
        cur = cur.parent
        moves += 1
    end
    path.unshift starting
    puts "The shortest path from #{starting} to #{ending} takes #{moves} moves."
    puts "Path:"
    puts "#{path}"
end

game = Game.new

knight_moves [1, 1], [5, 6]