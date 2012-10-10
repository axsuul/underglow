require 'spec_helper'

describe Symbol do
  it "should urlize a symbol properly" do
    :fuck_you_bitch.urlize.should == "fuck-you-bitch"
  end
end