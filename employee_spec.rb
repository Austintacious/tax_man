require 'rspec'
require_relative 'tax_man'


describe Employee do
  it 'instantiates new employee instance' do
    expect(Employee.new({"first_name"=>"Johnny","last_name"=>"Mills","annual_income"=>45000,"tax_paid"=> 9000,"tax_rate"=>30}).first).to eql("Johnny")
    expect(Employee.new({"first_name"=>"Mel","last_name"=>"Booo","annual_income"=>450034530,"tax_paid"=> 904400,"tax_rate"=>450}).tax_rate).to eql(450)
  end

  it "instantiates new employees even if they're missing their first name" do
    expect(Employee.new({"last_name"=>"Mills","annual_income"=>45000,"tax_paid"=> 9000,"tax_rate"=>30}).first).to eql("[First name]")
  end

  it "instantiates new employees even if they're missing their tax paid" do
    expect(Employee.new({"last_name"=>"Mills","annual_income"=>45000,"tax_rate"=>30}).tax_paid).to eql(0)
  end

  it "instantiates new employees even if they're missing their tax rate" do
    expect(Employee.new({"last_name"=>"Mills","annual_income"=>45000,"tax_paid"=> 9000}).tax_rate).to eql(30)
  end

  it "raises an error if the hash doesn't include a last name" do
    expect{Employee.new({"annual_income"=>45000,"tax_paid"=> 9000,"tax_rate"=>30})}.to raise_error(RuntimeError, "invalid input")
  end

  it "instaties employee if the hash doesn't include annual_income" do
    expect(Employee.new({"last_name"=>"Mills","tax_paid"=> 9000,"tax_rate"=>30}).annual_income).to eql(0)
  end
end
