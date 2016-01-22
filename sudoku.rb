# Takes a board as a string in the format
# you see in the puzzle file. Returns
# something representing a board after
# your solver has tried to solve it.
# How you represent your board is up to you!

def solve(board_string)
  board_string.length.times do |elm_idx|
    next if board_string[elm_idx] != 0
    possible_values = find_posssible_values(board_string, elm_idx)

    possible_values.each do |idx|
      board_string[elm_idx] = idx
      # solve(board_string)
      if solve(board_string)
        return [board_string, true]
      end
    end
    board_string[elm_idx] = 0
    return false

  end
  return [board_string, true]

end


def find_value_row_column(board_string, elm_idx)
  res = []
  row, column = elm_idx / 9 * 9, elm_idx % 9

  9.times do |idx|
    tmp_in_row = board_string[row + idx]
    res << tmp_in_row if tmp_in_row

    tmp_in_column = board_string[idx * 9 + column]
    res << tmp_in_column if tmp_in_column
  end

  res.uniq
end

def find_in_square(board_string, elm_idx)
  res = []
  sq_row = elm_idx / 27 * 3
  sq_column = elm_idx % 9 / 3 * 3

  3.times do |i|
    3.times do |j|
      tmp_sqr = board_string[(sq_row + i) * 9 + sq_column + j]
      res << tmp_sqr if tmp_sqr
    end
  end

  res.uniq
end

def find_posssible_values(board_string, elm_idx)
  possible_values = (1..9).to_a

  row = elm_idx / 9 * 9
  column = elm_idx % 9

  possible_values -= find_value_row_column(board_string, elm_idx)

  possible_values -= find_in_square(board_string, elm_idx)

  return possible_values
end

# Returns a boolean indicating whether
# or not the provided board is solved.
# The input board will be in whatever
# form `solve` returns.
def solved?(board)
  solve(board).last
end

# Takes in a board in some form and
# returns a _String_ that's well formatted
# for output to the screen. No `puts` here!
# The input board will be in whatever
# form `solve` returns.
def pretty_board(board)
  i = 0
  while i <= 81
    board.first.insert(i,"\n")
    i += 10
  end
  board.first.join(' ')
end
