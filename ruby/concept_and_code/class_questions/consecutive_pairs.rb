# def combine_pairs(arr)
#   arr.each_index do |i|
#     next if i == 0
#     yield(i)
#   end
# end

def combine_pairs(arr)
  (1..arr.size-1).each do |i|
    yield(i)
  end
end

arr = [1,2,3,4,5]

combine_pairs(arr) do |i|
  puts "(#{arr[i-1]}, #{arr[i]})"
end
