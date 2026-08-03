=begin
Write your code for the 'Tournament' exercise in this file. Make the tests in
`tournament_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/tournament` directory.
=end

=begin
Team                           | MP |  W |  D |  L |  P
Devastating Donkeys            |  3 |  2 |  1 |  0 |  7
Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6
Blithering Badgers             |  3 |  1 |  0 |  2 |  3
Courageous Californians        |  3 |  0 |  1 |  2 |  1
=end
=begin
Allegoric Alaskans;Blithering Badgers;win
Devastating Donkeys;Courageous Californians;draw
Devastating Donkeys;Allegoric Alaskans;win
Courageous Californians;Blithering Badgers;loss
Blithering Badgers;Devastating Donkeys;loss
Allegoric Alaskans;Courageous Californians;win
=end
hash = {} # Will represnt teams and their points
  # Maybe it's better to have team names as keys and array of size 3 representing MP, W, D as value
while true
  input = gets.chomp.split()
  p "Input array is: #{input}"

  # input[2] == "won" ? hsh[input[0]] = hash.has_key?(input[0]) ?  : hsh[input[1]] = [1,1,0]
  if input[2] == "win"
    if hash.has_key?(input[0])
      val = hash[input[0]]
      map = val[0]
      won = val[1]
      draw = val[2]
      hash[input[0]] = [map + 1, won + 1, draw]
    else
      hash[input[0]] = [1, 1, 0]
    end
  elsif input[2] == "loss"
    
  end
end