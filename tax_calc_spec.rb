require 'rspec'
require_relative 'tax_man'

describe TaxCalc do

  it 'will take an employee object' do
    expect(TaxCalc.new(Employee.new({"first_name"=>"Johnny","last_name"=>"Mills","annual_income"=>45000,"tax_paid"=> 9000,"tax_rate"=>30})).employee).to be_an_instance_of(Employee)
  end

  it 'will not accept any other type of input' do
    expect{(TaxCalc.new(hash))}.to raise_error(RuntimeError, "that is not a valid input")
    expect{(TaxCalc.new(43))}.to raise_error(RuntimeError, "that is not a valid input")
  end

  it 'calculates the tax liabilty for the employee' do
    expect(TaxCalc.new(Employee.new({"first_name"=>"Johnny","last_name"=>"Mills","annual_income"=>45000,"tax_paid"=> 9000,"tax_rate"=>30})).determine_liability).to eql(4500.0)
    expect(TaxCalc.new(Employee.new({"first_name"=>"Johnny","last_name"=>"Mills","annual_income"=>20000,"tax_rate"=>20})).determine_liability).to eql(4000.0)
    expect(TaxCalc.new(Employee.new({"first_name"=>"Johnny","last_name"=>"Mills","annual_income"=>50000,"tax_paid"=> 10000,"tax_rate"=>15})).determine_liability).to eql(-2500.0)
  end

  it 'creates an instance of the Liability class after determining the liability' do
    expect(TaxCalc.new(Employee.new({"first_name"=>"Johnny","last_name"=>"Mills","annual_income"=>20000,"tax_rate"=>20})).create_liability("hi")).to be_an_instance_of(Liability)
  end

end
