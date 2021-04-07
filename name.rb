require 'csv'
require 'pry'

class Name
  attr_reader :year, :bio_gender, :ethnicity, :name, :count, :rank
  @@filename = './popular_baby_names.csv'

  def initialize(data)
    # require "pry"; binding.pry
    # @year = 
    # @bio_gender = 
    # @ethnicity = 
    # @name = 
    # @count = 
    # @rank = 
  end

  def self.find_by_name(name)
    rows = CSV.read(@@filename, headers: true)
    result = []
    rows.each {|row| 
      result << Name.new(row) if row["Child's First Name"].downcase == name.downcase}
    result
    require "pry"; binding.pry
  end
end

Name.find_by_name("jason")