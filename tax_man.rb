require 'csv'
require 'pry'

class Employee

  attr_reader :first, :last, :annual_income, :tax_paid, :tax_rate

  def initialize(hash)
    hash["first_name"].nil? ? @first = "[First name]" : @first = hash["first_name"]
    hash["last_name"].nil? ? raise('invalid input') : @last = hash["last_name"]
    hash["annual_income"].nil? ? @annual_income = 0 : @annual_income = hash["annual_income"]
    hash["tax_paid"].nil? ? @tax_paid = 0 : @tax_paid = hash["tax_paid"]
    hash["tax_rate"].nil? ? @tax_rate = 30 : @tax_rate = hash["tax_rate"]
  end

end

class TaxCalc

  attr_reader :employee

  def initialize(employee)
    @employee = employee
    raise "that is not a valid input" unless @employee.kind_of?(Employee)
  end

  def determine_liability
    tax_rate = @employee.tax_rate.to_f/100
    liability =(@employee.annual_income.to_i*tax_rate).to_i - @employee.tax_paid.to_i
    create_liability(liability)
    liability
  end

  def create_liability(liability)
    Liability.new(@employee,liability)
  end
end

class Liability

  attr_reader :employee, :liability

  def initialize(person, liability)
    @employee = person
    @liability = liability
    puts_display
  end

  def display_output
    if @liability > 0
      "#{@employee.first} #{@employee.last} has a tax liability of $#{format_num(@liability)}"
    else
      "#{@employee.first} #{@employee.last} will receive a refund of $#{format_num(@liability.abs)}"
    end
  end

  def puts_display
    puts display_output
  end

  def format_num(num)
    num.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end

class CsvReader

  def initialize(filename)
    @filename = filename
  end

  def parser
    array = []
    CSV.foreach(@filename, headers:true) do |row|
      array << row
    end
    array
  end

end

class Runner

  def initialize
    @employee = []
    data = CsvReader.new('employees.csv').parser
    data.each do |employee|
      @employee << Employee.new(employee)
    end
    @employee.each do |employee|
      TaxCalc.new(employee).determine_liability
    end
  end

end

Runner.new

