require 'rspec'
require_relative 'tax_man'

describe Liability do

  it 'includes includes the employee property' do
    expect(Liability.new(Employee.new({"first_name"=>"Johnny","last_name"=>"Mills","annual_income"=>45000,"tax_paid"=> 9000,"tax_rate"=>30}), 4000).employee).to be_an_instance_of(Employee)
  end

  it 'includes includes a liability value' do
    expect(Liability.new(Employee.new({"first_name"=>"Johnny","last_name"=>"Mills","annual_income"=>45000,"tax_paid"=> 9000,"tax_rate"=>30}), 4000).liability).to eql(4000)
  end

  it 'outputs the tax liability if its a positive number' do
    expect(Liability.new(Employee.new({"first_name"=>"Johnny","last_name"=>"Mills","annual_income"=>45000,"tax_paid"=> 9000,"tax_rate"=>30}), 4500).display_output).to eql("Johnny Mills has a tax liability of $4,500")
  end

  it 'outputs the refund if it is a negative number' do
    expect(Liability.new(Employee.new({"first_name"=>"Johnny","last_name"=>"Mills","annual_income"=>45000,"tax_paid"=> 9000,"tax_rate"=>30}), -4500).display_output).to eql("Johnny Mills will receive a refund of $4,500")
  end

end
