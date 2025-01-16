#!/usr/bin/env ruby

# Generate all possible bishop placements
# we filter the placements to reject those placements where both bishops are on even squares or both are on odd squares
# e.g. bishops on [0,2], [1, 3], [2, 4], [2, 6] are not allowed
bishop_placements = (0..7).to_a.combination(2).to_a.select{|bishop_pair| (bishop_pair[0] % 2 != bishop_pair[1] % 2)}

all_pos = 0.upto(7).to_a
pos_strings = {}
bishop_placements.each do |b|
  b_h = b.to_h { |x| [x, 1] }
  remaining1 = all_pos - b
  #puts "#{b} => #{remaining1}"

  knight_placements = 0.upto(remaining1.size - 1).to_a.map{|i| remaining1[i]}.combination(2).to_a
  knight_placements.each do |n|
    n_h = n.to_h { |x| [x, 1] }
    remaining2 = all_pos - b - n
    #puts "#{b} => #{n} => #{remaining2}"
    queen_placement = 0.upto(remaining2.size - 1).to_a.map{|i| remaining2[i]}.combination(1).to_a
    queen_placement.each do |q|
      q_h = q.to_h { |x| [x, 1] }
      rkr = all_pos - b - n - q
      r = [rkr[0], rkr[2]]
      r_h = r.to_h { |x| [x, 1] }
      k = [rkr[1]]
      k_h = k.to_h { |x| [x, 1] }
      #puts "k_h is: #{k_h}"
      #puts "#{b} => #{n} => #{q} => #{rkr}"
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
      #puts "#{str} (#{b} => #{n} => #{q} => #{rkr})"
      pos_strings[str] = 1
    end
  end
end

max_cols = 4
max_rows = 60
count = 0
col_num = 0
row_num = 0
pos_strings.keys.sort.each do |v|
  if col_num % (max_rows * max_cols) == 0 and col_num != 0
    puts "=== end ====" # end the current page
  end

  col_num = col_num + 1
  row_num = col_num / max_cols + 1


  if col_num % (max_rows * max_cols) == 1
    puts "=== begin ====" # begin a new page
  end

  # we do not need to show row numbers
  #if col_num % max_cols == 1
  #  print "#{row_num}. "
  #end

  print "#{col_num.to_s.rjust(3)}. #{v} "
  if col_num % max_cols == 0
    print "\n"
  end

end

if col_num % (max_rows * max_cols) == 0 and col_num != 0
  puts "=== end ====" # end the current page
end
