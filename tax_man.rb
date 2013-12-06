class Employee

  attr_reader :first, :last, :annual_income, :tax_paid, :tax_rate

  def initialize(hash)
    hash["first_name"].nil? ? @first = "[First name]" : @first = hash["first_name"]
    hash["last_name"].nil? ? raise('invalid input') : @last = hash["last_name"]
    hash["annual_income"].nil? ? raise('invalid input') : @annual_income = hash["annual_income"]
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
    liability =(@employee.annual_income*tax_rate) - @employee.tax_paid
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
  end
end
