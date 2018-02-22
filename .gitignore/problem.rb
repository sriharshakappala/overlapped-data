require 'pry'

def find_overlapped_data data
  data.sort_by! { |hsh| hsh[:start] }
  nth = 0
  nthp1 = 1
  while  nthp1 != data.count
    new_fragment = merge_data(data[nth], data[nthp1])
    if new_fragment.count == 1
      data.shift(2)
      data.unshift(new_fragment.first)
    else
      nth += 1
      nthp1 += 1
    end
  end
  puts data
end

def merge_data fragment1, fragment2
  if fragment1[:end] == fragment2[:start]
    return [{start: fragment1[:start], end: fragment2[:end]}]
  elsif (fragment1[:start] <= fragment2[:start]) && (fragment1[:end] >= fragment2[:end])
    return [fragment1]
  elsif (fragment1[:start] >= fragment2[:start]) && (fragment1[:end] <= fragment2[:end])
    return [fragment2]
  elsif (fragment1[:start] >= fragment2[:start]) && (fragment1[:end] >= fragment2[:end])
    return [{start: fragment2[:start], end: fragment1[:end]}]
  elsif (fragment1[:start] <= fragment2[:start]) && (fragment1[:end] <= fragment2[:end]) && (fragment1[:end] >= fragment2[:start])
    return [{start: fragment1[:start], end: fragment2[:end]}]
  elsif (fragment1[:start] <= fragment2[:start]) && (fragment1[:end] <= fragment2[:end])
    return [fragment1, fragment2]
  end
end

data = [
  {start: 0, end: 10},
  {start: 10, end: 20},
  {start: 0, end: 3},
  {start: 5, end: 10},
  {start: 40, end: 50},
  {start: 55, end: 57},
  {start: 9, end: 27},
  {start: 19, end: 37},
  {start: 37, end: 40},
]

find_overlapped_data data
