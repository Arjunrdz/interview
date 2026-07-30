require 'date'
data = [
    {
        username: "Arjun",
        email: "demo@gmail.com",
        last_login: Date.new(2026, 7, 23)
    },
    {
        username: "John",
        email: "john@gmail.com",
        last_login: Date.new(2026, 6, 25)
    },
    {
        username: "Emma",
        email: "emma@gmail.com",
        last_login: Date.new(2026, 5, 18)
    },
    {
        username: "Sophia",
        email: "sophia@gmail.com",
        last_login: Date.new(2026, 4, 30)
    },
    {
        username: "Liam",
        email: "liam@gmail.com",
        last_login: Date.new(2026, 3, 15)
    },
    {
        username: "Noah",
        email: "noah@gmail.com",
        last_login: Date.new(2026, 2, 11)
    },
    {
        username: "Olivia",
        email: "olivia@gmail.com",
        last_login: Date.new(2026, 1, 28)
    },
    {
        username: "Ava",
        email: "ava@gmail.com",
        last_login: Date.new(2025, 12, 20)
    },
    {
        username: "Mason",
        email: "mason@gmail.com",
        last_login: Date.new(2025, 11, 9)
    },
    {
        username: "Isabella",
        email: "isabella@gmail.com",
        last_login: Date.new(2026, 5, 5)
    },
    {
        username: "Ethan",
        email: "ethan@gmail.com",
        last_login: Date.new(2026, 6, 10)
    },
    {
        username: "Mia",
        email: "mia@gmail.com",
        last_login: Date.new(2026, 4, 12)
    }
]

threshold = Date.new(2026, 7, 23)
one_month_ago = threshold << 1

# using procs
procs_filtered = Proc.new do |users|
  users.select {|user| user[:last_login] >= one_month_ago}
end

p procs_filtered.call(data)




















# today = Date.new(2026, 7, 23)
# one_month_ago = today << 1

# user_filter_proc = Proc.new do |users|
#     users.select { |user| user[:last_login] >= one_month_ago}
# end

# user_filter_lambda = -> (users) do 
#     users.select {|user| user[:last_login] >= one_month_ago}
# end

# puts "Using proc:"
# p user_filter_proc.call(data)

# puts "\n Using lambda:"
# p user_filter_lambda.call(data)