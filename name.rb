require 'csv'
require 'pry'

class Name
  attr_reader :year, :bio_gender, :ethnicity, :name, :count, :rank, :data
  @@filename = './popular_baby_names.csv'

  def initialize(data)
    @year = data["Year of Birth"]
    @gender = data["Gender"]
    @ethnicity = data["Ethnicity"]
    @name = data["Child's First Name"]
    @count = data["Count"]
    @rank = data["Rank"]
    @data = data
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
    newrows = []
    i = 0
    until i == details.length
      format_details_to_csv = details.keys[i].to_s.capitalize

      if details.keys[i].to_s.to_i == 0
        detail_value = details.values[i].upcase
      else
        detail_value = details.values[i]
      end

      rows = rows.select do |row| 
        case format_details_to_csv
        when "Year"
          format_details_to_csv = "Year of Birth"
        when "Name"
          format_details_to_csv = "Child's First Name"
        end
        if row[format_details_to_csv].to_i == 0
          row[format_details_to_csv].downcase == detail_value.downcase
        else 
          row[format_details_to_csv] == detail_value
        end
      end

      i += 1
    end

    rows.each {|row| newrows << Name.new(row)}
    newrows
  end

  def self.step_array(arr, param, key)
    newarr = []

    arr.each do |ele| 
      if ele.class != Array 
        if param[1] == :desc || param[1] == :descending
          return arr.sort_by {|row| row[key]}.reverse!.group_by{|row| row[key]}.values
        else 
          return arr.sort_by {|row| row[key]}.group_by{|row| row[key]}.values
        end 
      end

      newarr << step_array(ele, param, key)
    end
    
    newarr
  end

  def self.order(hashdata)
    rows = CSV.read(@@filename, headers: true)
    result = []
    
    hashdata.each do |param|
      
      key = param.first.to_s.capitalize
      case key
      when "Year"
        key = "Year of Birth"
      when "Name"
        key = "Child's First Name"
      end

      if result != []
        result = step_array(result, param, key)
      else  
        if param[1] == :desc || param[1] == :descending
          result = rows.sort_by {|row| row[key]}.reverse!.group_by{|row| row[key]}.values
        else 
          result = rows.sort_by {|row| row[key]}.group_by{|row| row[key]}.values
        end
      end
    end

    result.flatten.map! {|ele| Name.new(ele)} 
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

puts Name.where({ name: "GERALDINE", rank: "75" })[0].class

puts Name.order( { ethnicity: :asc, name: :descending } ).length
puts Name.order( { ethnicity: :asc, name: :descending } )[0].data
puts Name.order( { ethnicity: :asc, name: :descending } )[10].data
puts Name.order( { ethnicity: :asc, name: :descending } )[100].data
puts Name.order( { ethnicity: :asc, name: :descending } )[1000].data

puts Name.order( { ethnicity: :asc, name: :descending } )[10000].data
puts Name.order( { ethnicity: :asc, name: :descending } )[10001].data
puts Name.order( { ethnicity: :asc, name: :descending } )[10002].data
puts Name.order( { ethnicity: :asc, name: :descending } )[10003].data
puts Name.order( { ethnicity: :asc, name: :descending } )[10004].data
puts Name.order( { ethnicity: :asc, name: :descending } )[10005].data

puts Name.order( { ethnicity: :asc, name: :descending } )[20000].data
puts Name.order( { ethnicity: :asc, name: :descending } )[20001].data
puts Name.order( { ethnicity: :asc, name: :descending } )[20002].data
puts Name.order( { ethnicity: :asc, name: :descending } )[20003].data
puts Name.order( { ethnicity: :asc, name: :descending } )[20004].data
puts Name.order( { ethnicity: :asc, name: :descending } )[20005].data

puts Name.order( { ethnicity: :asc, name: :descending } )[25000].data
puts Name.order( { ethnicity: :asc, name: :descending } )[25001].data
puts Name.order( { ethnicity: :asc, name: :descending } )[25002].data
puts Name.order( { ethnicity: :asc, name: :descending } )[25003].data
puts Name.order( { ethnicity: :asc, name: :descending } )[25004].data
puts Name.order( { ethnicity: :asc, name: :descending } )[25005].data

puts Name.order( { ethnicity: :asc, name: :descending } )[29000].data
puts Name.order( { ethnicity: :asc, name: :descending } )[29001].data
puts Name.order( { ethnicity: :asc, name: :descending } )[29002].data
puts Name.order( { ethnicity: :asc, name: :descending } )[29003].data
puts Name.order( { ethnicity: :asc, name: :descending } )[29004].data
puts Name.order( { ethnicity: :asc, name: :descending } )[29005].data

puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[1].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[2].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[3].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[4].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[6].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[7].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[8].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[9].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[10].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[11].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[12].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[13].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[14].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[15].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[16].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[17].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[18].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[19].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[20].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[21].data
puts Name.order( { name: :asc, year: :descending, ethnicity: :descending } )[22].data