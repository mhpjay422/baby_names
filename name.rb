require 'csv'
require 'pry'

class Name
  attr_reader :year, :bio_gender, :ethnicity, :name, :count, :rank
  @@filename = './popular_baby_names.csv'

  def initialize(data)
    @year = data["Year of Birth"]
    @gender = data["Gender"]
    @ethnicity = data["Ethnicity"]
    @name = data["Child's First Name"]
    @count = data["Count"]
    @rank = data["Rank"]
  end

  def self.find_by_name(name)
    rows = CSV.read(@@filename, headers: true)
    result = []
    rows.each {|row| 
      result << Name.new(row) if row["Child's First Name"].downcase == name.downcase}
    result
  end

  def self.find_by_year(year)
    rows = CSV.read(@@filename, headers: true)
    result = []
    rows.each {|row| 
      # binding.pry
      result << Name.new(row) if row["Year of Birth"] == year.to_s}
    result
  end
end

puts Name.find_by_name("jason").length 
puts Name.find_by_name("Ian").length 
puts Name.find_by_name("MEGAN").length 
puts Name.find_by_name("Sal").length 
puts Name.find_by_name("Omar").length 
puts Name.find_by_name("Riley").length 
puts Name.find_by_name("HUNTER").length
puts Name.find_by_year(2011).length
