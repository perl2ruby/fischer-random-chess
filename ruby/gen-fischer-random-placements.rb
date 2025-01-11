#!/usr/bin/env ruby
# This script generates portions of LaTeX code to be inserted into a pre-existing LaTeX file
# Generate all possible bishop placements
bishop_placements = (0..7).to_a.combination(2).to_a.select{|bishop_pair| (bishop_pair[0] % 2 != bishop_pair[1] % 2)}

all_pos = 0.upto(7).to_a
pos_strings = {}
bishop_placements.each do |b|
  b_h = b.to_h { |x| [x, 1] }
  remaining1 = all_pos - b
  #puts "#{b} => #{remaining1}"
  #knight_placements = (0.upto(#{remaining1.size - 1})).to_a.map{|i| remaining1[i]}.combination(2).to_a
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
#puts "\\begin\{tiny\}"
puts %Q(
\\storechessboardstyle{8x1}{%
labelbottom=false,
labelleft=false,
maxfield=h1,
borderwidth=0.5mm,
color=white,
colorwhitebackfields,
blackfieldmaskcolor=black,
whitepiecemaskcolor=red,
blackpiececolor=cyan,
blackpiecemaskcolor=blue,
addfontcolors,
pgfstyle=border,
color=white,
markregion=a1-h1,
showmover=false,
hlabelwidth=4pt,
vlabellift=0pt}
)
max_cols = 2
max_rows = 16
count = 0
col_num = 0
row_num = 0
board_font_size = '12pt'

pos_strings.keys.sort.each do |v|
  if col_num % (max_rows * max_cols) == 0 and col_num != 0
    #puts "=== end ===="
    puts '\end{tabular}'
  end

  col_num = col_num + 1
  row_num = col_num / max_cols + 1
  

  if col_num % (max_rows * max_cols) == 1
    #puts "=== begin ===="
    puts '\newpage'
    puts '\begin{tabular}{|c|c|}'
    puts '\hline'
    puts '\rowcolor{lightgray}'
    puts '\textbf{C1} & \textbf{C2} \\\\\hline'
  end

  if col_num % max_cols != 1
    print ' & '
  end

  if v == "RNBQKBNR" # normal game
    print '\cellcolor{blue!25}\textcolor{red}{' + col_num.to_s + ". \\textbf\{#{v}\}" + '} ' + "\\chessboard\[style=8x1,boardfontsize=#{board_font_size},setpieces=\{" +
           v.split(%r{}).each_with_index.map {|c,i| c + ("a".ord + i).chr.to_s + "1"}.join(",") +
           "\},padding=0.2ex\] "
  else
    print col_num.to_s + ". \\textbf\{#{v}\} " + "\\chessboard\[style=8x1,boardfontsize=#{board_font_size},setpieces=\{" +  
           v.split(%r{}).each_with_index.map {|c,i| c + ("a".ord + i).chr.to_s + "1"}.join(",") +
           "\},padding=0.2ex\] "
  end
  if col_num % max_cols == 0
    if col_num / max_cols != 0
      puts ' \\\\' + '\hline'
    end
  end
end

if col_num % (max_rows * max_cols) == 0 and col_num != 0
  #puts "=== end ===="
  puts '\end{tabular}'
end
#puts "\\end\{tiny\}"
