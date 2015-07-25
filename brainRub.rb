#!/usr/bin/ruby
require "highline/system_extensions"
include HighLine::SystemExtensions
filename = ARGV[0]
progdata = if filename.nil?
  "++++++++[>+>++>+++>++++>+++++>++++++>+++++++>++++++++>+++++++++>++++++++++>+++++++++++>++++++++++++>+++++++++++++>++++++++++++++>+++++++++++++++>++++++++++++++++<<<<<<<<<<<<<<<<-]>>>>>>>>>>>---.+++<<<<<<<<<<<>>>>>>>>>>>>>>+++.---<<<<<<<<<<<<<<>>>>>>>>>>>>+.-<<<<<<<<<<<<>>>>>>>>>>>>>-.+<<<<<<<<<<<<<>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<>>>>>>>++.--<<<<<<<>>>>.<<<<>>>>>>--.++<<<<<<>>>>>>-.+<<<<<<>>>>>>>>>>>>++.--<<<<<<<<<<<<>>>>>>>>>>>>>>++.--<<<<<<<<<<<<<<>>>>>>>>>>>>+.-<<<<<<<<<<<<>>>>>>>>>>>>>+.-<<<<<<<<<<<<<>>>>>>>>>>>>>>--.++<<<<<<<<<<<<<<>>>>>>>>>>++.--<<<<<<<<<<>>>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<<<>>>>>>>>>>>>++.--<<<<<<<<<<<<>>>>>>--.++<<<<<<>>>>>>>>>>>>>>++.--<<<<<<<<<<<<<<>>>>>>>>>>>>++.--<<<<<<<<<<<<>>>>.<<<<>>>>>>>>>>>>>>.<<<<<<<<<<<<<<>>>>>>>>>>>>>>++.--<<<<<<<<<<<<<<>>>>>>>>>>>>>>-.+<<<<<<<<<<<<<<>>>>>>>>>>>>>-.+<<<<<<<<<<<<<>>>>>>>>>>>>>>++.--<<<<<<<<<<<<<<>>>>>>>>>>>>+.-<<<<<<<<<<<<>>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<<>>>>>>>>>>--.++<<<<<<<<<<>>>>>>>>>>>>+.-<<<<<<<<<<<<>>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<<>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<>>>>>>--.++<<<<<<>>>>>>>>>>>>++.--<<<<<<<<<<<<>>>>>>>>>>>>>--.++<<<<<<<<<<<<<>++.--<."
elsif !File.exists? filename
  "++++++++[>+>++>+++>++++>+++++>++++++>+++++++>++++++++>+++++++++>++++++++++>+++++++++++>++++++++++++>+++++++++++++>++++++++++++++>+++++++++++++++>++++++++++++++++<<<<<<<<<<<<<<<<-]>>>>>>>>>--.++<<<<<<<<<>>>>>>>>>>>>>+.-<<<<<<<<<<<<<>>>>>>>>>>>>>>----.++++<<<<<<<<<<<<<<>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<>>>>.<<<<>>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<<>>>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<<<>>>>>>>>>>>>>>+++.---<<<<<<<<<<<<<<>>>>>>>>>>>>>>>----.++++<<<<<<<<<<<<<<<>>>>.<<<<>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<>>>>>>>>>>>>>>>.<<<<<<<<<<<<<<<>>>>>>>>>>>>>+.-<<<<<<<<<<<<<>>>>>>>>>>>>>>+++.---<<<<<<<<<<<<<<>>>>>>>>>>>>>>>----.++++<<<<<<<<<<<<<<<>++.--<."
elsif !File.readable? filename
  "++++++++[>+>++>+++>++++>+++++>++++++>+++++++>++++++++>+++++++++>++++++++++>+++++++++++>++++++++++++>+++++++++++++>++++++++++++++>+++++++++++++++>++++++++++++++++<<<<<<<<<<<<<<<<-]>>>>>>>>>--.++<<<<<<<<<>>>>>>>>>>>>>+.-<<<<<<<<<<<<<>>>>>>>>>>>>>>----.++++<<<<<<<<<<<<<<>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<>>>>.<<<<>>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<<>>>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<<<>>>>>>>>>>>>>>+++.---<<<<<<<<<<<<<<>>>>>>>>>>>>>>>----.++++<<<<<<<<<<<<<<<>>>>.<<<<>>>>>>>>>>>>++.--<<<<<<<<<<<<>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<>>>>.<<<<>>>>>>>>>>>>>>++.--<<<<<<<<<<<<<<>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<>>>>>>>>>>>>+.-<<<<<<<<<<<<>>>>>>>>>>>>>----.++++<<<<<<<<<<<<<>>>>>>>>>>>>+.-<<<<<<<<<<<<>>>>>>>>>>>>++.--<<<<<<<<<<<<>>>>>>>>>>>>>>----.++++<<<<<<<<<<<<<<>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<>++.--<."
else
  IO.read(filename).scan(/>|<|\+|-|\.|,|\[|\]/)
end
tape = []
tPtr = 0
pPtr = 0
while pPtr < progdata.length
  case progdata[pPtr]
  when '>'
    tPtr += 1
  when '<'
    tPtr -= 1
  when '+'
    tape[tPtr] = tape[tPtr].to_i + 1
  when '-'
    tape[tPtr] = tape[tPtr].to_i - 1
  when ','
    tape[tPtr] = get_character.to_i
  when '.'
    print tape[tPtr].chr
  when '['
    if tape[tPtr].to_i.zero?
      count = 1
      while count > 0 do
        count += 1 if (char = progdata[(pPtr += 1)]) == '['
        count -= 1 if char == ']'
      end
    end
  when ']'
    unless tape[tPtr].to_i.zero?
      count = 1
      while count > 0 do
        count -= 1 if (char = progdata[(pPtr -= 1)]) == '['
        count += 1 if char == ']'
      end
      next
    end
  end
  pPtr += 1
end
