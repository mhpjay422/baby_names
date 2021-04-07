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
    rows.each {|row| result << Name.new(row) if row["Year of Birth"] == year.to_s}
    result
  end

  def self.where(details)
    rows = CSV.read(@@filename, headers: true)
    result = []
    format_details_to_csv = details.keys[0].to_s.capitalize
    if details.keys[0].to_s.to_i == 0
      detail_value = details.values[0].upcase
    else
      detail_value = details.values[0]
    end
    rows.each {|row| result << Name.new(row) if row[format_details_to_csv] == detail_value}
    result
  end

  def self.order(hashdata)
    rows = CSV.read(@@filename, headers: true)
    result = []
    key = hashdata.keys.first.to_s.capitalize
    case key
    when "Year"
      key = "Year of Birth"
    when "Name"
      key = "Child's First Name"
    end

    rows.sort_by {|row| row[key]}
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

puts Name.where({ rank: "15" }).length
puts Name.where({ rank: "25" }).length
puts Name.where({ gender: "male" }).length
puts Name.where({ gender: "female" }).length
puts Name.where({ Ethnicity: "BLACK NON HISPANIC" }).length

puts Name.order( { year: :asc }).first
puts Name.order( { year: :asc })[-1]


puts Name.order( { name: :desc }).first
puts Name.order( { name: :desc })[-1]