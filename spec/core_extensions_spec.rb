require 'spec_helper'

describe "String" do
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


  it "should be able to deurlize to symbol" do
    "solid-state-drive".deurlize_to_sym.should == :solid_state_drive
  end

  it "should be able to tell if the string is numeric" do
    "1".should be_numeric
    "1.22".should be_numeric
  end

  it "should be able to tell if string is a url" do
    "http://google.com".url?.should == true
    "https://192.168.1.200:3000/fucky".url?.should == true
    "hahahah".url?.should == false
  end

  it "should initial captalize" do
    "what the fuck".initial_capitalize.should == "What the fuck"
    "what the FUCK".initial_capitalize.should == "What the FUCK"
  end

  it "should convert to something proper for html attributes" do
    "Sandbox".html_attributify.should == "sandbox"
    "not sure WHAT you mean".html_attributify.should == "not-sure-what-you-mean"
    "what_the_fuck!!!!".html_attributify.should == "what-the-fuck"
    "builds/blah".html_attributify.should == "builds-blah"
  end

  context "overlapping" do
    it "should append if it doesn't overlap at the end" do
      "Core i6".overlap("i5-2500k").should == "Core i6i5-2500k"      
      "The day is good".overlap("was good").should == "The day is goodwas good"
    end

    it "should overlap if it overlaps at the end" do
      "FX".overlap("FX-2500").should == "FX-2500"
      "Core i5".overlap("i5-2500k 3.2 GHz").should == "Core i5-2500k 3.2 GHz"
      "Today is really beautiful".overlap("is really beautiful!").should == "Today is really beautiful!"
      "Just fuck off".overlap("fuck off").should == "Just fuck off"
      "Oh whilly nil".overlap("whilly nilly").should == "Oh whilly nilly"
    end
  end

  context "sanitizing ascii only" do
    it "should be able to get rid of non-ascii characters" do
      str = "ATI Radeon\u2122 HD 4250 GPU"
      str.ascii_only!
      str.should == "ATI Radeon HD 4250 GPU"
    end  

    it "should not change the encoding" do
      str = "ATI Radeon\u2122 HD 4250 GPU"
      original_encoding = str.encoding.name
      
      str.ascii_only!
      str.encoding.name.should == original_encoding
    end
  end
  
end

describe Symbol do
  it "should urlize a symbol properly" do
    :fuck_you_bitch.urlize.should == "fuck-you-bitch"
  end
end