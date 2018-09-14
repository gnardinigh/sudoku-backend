class Puzzle < ApplicationRecord

  #
  # def self.hasValidColumns(numbers)
  #   # reversedMatrix = []
  #   # numbers.each_with_index do |arr, indexArr|
  #   #   arr.each_with_index do |num, indexNum|
  #   #     reversedMatrix[indexOne]
  #   #   end
  #   # end
  #   correctNums = [1,2,3,4,5,6,7,8,9]
  #   for i in (0..8)
  #     nums = []
  #     nums.push(numbers[0][i])
  #     nums.push(numbers[1][i])
  #     nums.push(numbers[2][i])
  #     nums.push(numbers[3][i])
  #     nums.push(numbers[4][i])
  #     nums.push(numbers[5][i])
  #     nums.push(numbers[6][i])
  #     nums.push(numbers[7][i])
  #     nums.push(numbers[8][i])
  #
  #     sorted = nums.sort
  #
  #     if sorted != correctNums
  #       return false
  #     end
  #   end
  #   return true
  # end
  #
  # def self.generateRandomNumbers
  #   nums = [1,2,3,4,5,6,7,8,9]
  #   puzzleNumbers = []
  #   9.times do
  #     nums = nums.shuffle
  #     puzzleNumbers.push(nums)
  #   end
  #   return puzzleNumbers
  # end
  #
  # def self.generatePuzzle
  #   numbers = Puzzle.generateRandomNumbers
  #   until Puzzle.hasValidColumns(numbers) do
  #     numbers = Puzzle.generateRandomNumbers
  #   end
  #   binding.pry
  #   return numbers
  #   ##DON'T FORGET TO STRINGIFY NUMBERS MATRIX
  # end
  #


##ATTEMPTING ANOTHER WAY!! ----

  def self.generateBlankMatrix
    matrix = []
    9.times do
      row = []
      9.times do
        row.push(0)
      end
      matrix.push(row)
    end
    return matrix
  end

  def self.checkRowValidity(randNum, populatedMatrix, rowIndex)
    row = populatedMatrix[rowIndex]
    return !row.include?(randNum)
  end

  def self.checkColValidity(randNum, populatedMatrix, colIndex)
    nums = []
    for i in (0..8)
      nums.push(populatedMatrix[i][colIndex])
    end
    return !nums.include?(randNum)
  end

  def self.locateSquare(rowIndex, colIndex)
    return (((colIndex / 3) + 1).floor + ((rowIndex / 3).floor) * 3)
  end

  def self.numsInSquare(populatedMatrix, square)
    numsArr = []
    populatedMatrix.each_with_index do |row, rowIndex|
      row.each_with_index do |num, colIndex|
        if (((colIndex / 3) + 1).floor + ((rowIndex / 3).floor) * 3) == square
          numsArr.push(populatedMatrix[rowIndex][colIndex])
        end
      end
    end
    return numsArr
  end

  def self.checkSquareValidity(randNum, populatedMatrix, rowIndex, colIndex)
    square = Puzzle.locateSquare(rowIndex, colIndex)
    numsArray = Puzzle.numsInSquare(populatedMatrix, square)
    return !numsArray.include?(randNum)
  end

  def self.checkValidity(randNum, populatedMatrix, rowIndex, colIndex)
    rowValidity = Puzzle.checkRowValidity(randNum, populatedMatrix, rowIndex)
    colValidity = Puzzle.checkColValidity(randNum, populatedMatrix, colIndex)
    squareValidity = Puzzle.checkSquareValidity(randNum, populatedMatrix, rowIndex, colIndex)
    return rowValidity && colValidity && squareValidity
  end

  def self.populateMatrix(blankMatrix)
    populatedMatrix = Puzzle.generateBlankMatrix
    blankMatrix.each_with_index do |row, rowIndex|
      row.each_with_index do |num, colIndex|
        possibleNums = [1,2,3,4,5,6,7,8,9]
        randNum = rand(1..9)
        until checkValidity(randNum, populatedMatrix, rowIndex, colIndex) do
          possibleNums.delete(randNum)
          if possibleNums == []
            return Puzzle.populateMatrix(blankMatrix)
          end
          randNum = possibleNums[rand(0..possibleNums.length-1)]
        end
        populatedMatrix[rowIndex][colIndex] = randNum
      end
    end
    return populatedMatrix
  end

  def self.convertToString(matrix)
    stringVersion = matrix.flatten.join("")
  end

  def self.turnToMedium(stringVersion)
    copy = stringVersion.clone
        until copy.count('0') == 35
            done_status = false
            unless done_status
                rand_index = rand(81)
                if copy[rand_index]!='0'
                    copy[rand_index]='0'
                    done_status = true
                end
            end
        end
        return copy
  end

  def self.createPuzzle
    blankMatrix = Puzzle.generateBlankMatrix
    matrix = Puzzle.populateMatrix(blankMatrix)
    stringVersion = Puzzle.convertToString(matrix)
    puzzleVersion = Puzzle.turnToMedium(stringVersion)
    return {difficulty: "mystery", numbers: stringVersion, start: puzzleVersion}
  end


## -------------------------------

end ##END OF CLASS
