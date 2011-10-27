require 'spec_helper'

describe "core extensions" do
  it "should coerce a string to proper data type if no argument is given" do
    "hello world".coerce.class.name.should == "String"
    "5".coerce.class.name.should == "Fixnum"
    "3.14".coerce.class.name.should == "Float"
    "true".coerce.should == true
    "false".coerce.should == false
  end

  it "should coerce to the data type if given an argument" do
    "5".coerce(:string).class.name.should == "String"
    "5".coerce(:integer).class.name.should == "Fixnum"
    "5".coerce(:float).class.name.should == "Float"
  end

  it "should coerce to false if given a boolean to coerce to and is anything but true" do
    "true".coerce(:boolean).should == true
    "false".coerce(:boolean).should == false
    "5".coerce(:boolean).should == false
  end
end