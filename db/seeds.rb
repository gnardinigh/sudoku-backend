require 'csv'

file = File.expand_path('../db/sudoku_boards.csv', 'sudoku_boards.csv')

all_rows=[]

CSV.foreach(file) do |row|
    all_rows.push(row)
end

easy_rows = []
medium_rows = []
hard_rows = []

all_rows.each_with_index {|row,index|
    if index < 90
        easy_rows << row
    elsif index < 180 && index > 89
        medium_rows << row
    else
        hard_rows << row
    end
}

puts hard_rows.inspect

easy_string = easy_rows.flatten!.join('')
medium_string = medium_rows.flatten!.join('')
hard_string = hard_rows.flatten!.join('')


easy_solutions = []
medium_solutions = []
hard_solutions = []

10.times do
    easy_puzzle_string = easy_string.slice!(0..80)
    easy_solutions.push(easy_puzzle_string)
end

10.times do
    medium_puzzle_string = medium_string.slice!(0..80)
    medium_solutions.push(medium_puzzle_string)
end
7
10.times do
    hard_puzzle_string = hard_string.slice!(0..80)
    hard_solutions.push(hard_puzzle_string)
end

easy_boards = easy_solutions.map(&:clone)
medium_boards = medium_solutions.map(&:clone)
hard_boards = hard_solutions.map(&:clone)

easy_boards.each do |string| 
    25.times do
        done_status = false
        unless done_status
            rand_index = rand(81)
            if string[rand_index]!='0'
                string[rand_index]='0'
                done = true
            end
        end
    end
end

medium_boards.each do |string| 
    35.times do
        done_status = false
        unless done_status
            rand_index = rand(81)
            if string[rand_index]!='0'
                string[rand_index]='0'
                done = true
            end
        end
    end
end

hard_boards.each do |string| 
    45.times do
        done_status = false
        unless done_status
            rand_index = rand(81)
            if string[rand_index]!='0'
                string[rand_index]='0'
                done = true
            end
        end
    end
end


for i in (0..9)
    Puzzle.create(difficulty:'easy',numbers:easy_solutions[i],start:easy_boards[i])
end

for i in (0..9)
    Puzzle.create(difficulty:'medium',numbers:medium_solutions[i],start:medium_boards[i])
end

for i in (0..9)
    Puzzle.create(difficulty:'hard',numbers:hard_solutions[i],start:hard_boards[i])
end







