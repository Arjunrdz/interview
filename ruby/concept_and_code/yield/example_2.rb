# custom iterator
class Team
  def initialize(members)
    @members = members
  end

  def each_member
    
  end
end

team = Team.new(["Alice", "Bob", "Carol"]) # => Alice\nBob\nCarol

team.each_member do |member|
  puts member
end