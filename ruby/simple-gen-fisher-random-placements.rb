#!/usr/bin/env ruby

# Generate all possible bishop placements
# we filter the placements to reject those placements where both bishops are on even squares or both are on odd squares
# e.g. bishops on [0,2], [1, 3], [2, 4], [2, 6] are not allowed
bishop_placements = (0..7).to_a.combination(2).to_a.select{|bishop_pair| (bishop_pair[0] % 2 != bishop_pair[1] % 2)}
all_pos = 0.upto(7).to_a
pos_strings = {} # keys are  RNBQKBNR (rook, knight, ....), RBBQKNNR (rook, bishop,....) etc.
pos_num = 0

bishop_placements.each do |b|
  b_h = b.to_h { |x| [x, 1] }
  remaining1 = all_pos - b
  knight_placements = 0.upto(remaining1.size - 1).to_a.map{|i| remaining1[i]}.combination(2).to_a

  knight_placements.each do |n|
    n_h = n.to_h { |x| [x, 1] }
    remaining2 = all_pos - b - n
    queen_placement = 0.upto(remaining2.size - 1).to_a.map{|i| remaining2[i]}.combination(1).to_a

    queen_placement.each do |q|
      q_h = q.to_h { |x| [x, 1] }
      rkr = all_pos - b - n - q
      r = [rkr[0], rkr[2]]
      r_h = r.to_h { |x| [x, 1] }
      k = [rkr[1]]
      k_h = k.to_h { |x| [x, 1] }
      str = ""
      0.upto(7).to_a.each do |i|
        if b_h.key?(i)
          str = str + "B"
        elsif n_h.key?(i)
          str = str + "N"
        elsif q_h.key?(i)
          str = str + "Q"
        elsif r_h.key?(i)
          str = str + "R"
        elsif k_h.key?(i)
          str = str + "K"
        end
      end
      pos_num += 1
      pos_strings[str] = pos_num
    end
  end
end

max_cols = 4
max_rows = 60
count = 0
col_num = 0
row_num = 0
pos_strings.keys.sort {|a,b| pos_strings[a] <=> pos_strings[b] }.each do |v|
  puts "=== end ====" if col_num % (max_rows * max_cols) == 0 and col_num != 0 # end the current page
  col_num = pos_strings[v]
  row_num = col_num / max_cols + 1
  puts "=== begin ====" if col_num % (max_rows * max_cols) == 1 # begin a new page
  if col_num % max_cols == 1
    print "row #{row_num.to_s.rjust(4)}: #{col_num.to_s.rjust(3)}. #{v} "
  else
    print "#{col_num.to_s.rjust(3)}. #{v} "
  end
  print "\n" if col_num % max_cols == 0

end

puts "=== end ====" if col_num % (max_rows * max_cols) == 0 and col_num != 0 # end the current page
