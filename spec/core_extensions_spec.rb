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

  context "formatting numeric string with only significant digits" do
    it "should leave whole numbers alone" do
      "300000".format_numeric.should == "300000"
      "69".format_numeric.should == "69"
      "0".format_numeric.should == "0"
    end

    it "should remove trailing zeros if it ends with zeros" do
      "30.0".format_numeric.should == "30"
      "30.000000".format_numeric.should == "30"
      "30.3300000".format_numeric.should == "30.33"
      "30.30300000".format_numeric.should == "30.303"
    end

    it "should format multiple zeros to one zero before decimal" do
      "000000000000".format_numeric.should == "0"
      "000000000000.00000000000000".format_numeric.should == "0"
      "0.00000000000000".format_numeric.should == "0"
    end

    it "should not remove zeros after decimal if it ends with non-zero" do
      "30.00000001".format_numeric.should == "30.00000001"
      "2.210".format_numeric.should == "2.21"
    end

    it "should be able to limit the number of decimal places and round if it surpasses it" do
      "30.000001".format_numeric(4).should == "30"
      "30.00005".format_numeric(4).should == "30.0001"
      "30.02".format_numeric(1).should == "30"
      "30.05".format_numeric(1).should == "30.1"
      "30.05".format_numeric(1).should == "30.1"
    end
  end
end

describe Symbol do
  it "should urlize a symbol properly" do
    :fuck_you_bitch.urlize.should == "fuck-you-bitch"
  end
end

# describe Hash do
#   context "symbolizing keys" do
#     def test_hash(hash) 
#       hash.each do |key, value|
#         key.should be_a(Symbol)
#         test_hash(value) if value.is_a?(Hash)
#       end
#     end

#     before do
#       @simple_hash = {
#         'foo' => "bar",
#         'bitch' => "baz",
#         'fuck' => "you"
#       }

#       @deep_hash = {
#         'foo' => "bar",
#         'bitch' => {
#           'ass' => "hole",
#           'fuck' => {
#             'fuck' => "you",
#             'shit' => "you",
#             'showstopper' => {
#               'fuckin' => 'eh',
#               'btich' => 'fuck',
#               'one' => {
#                 'more' => "time"
#               }
#             }
#           }
#         },
#         'fuck' => {
#           'get' => "out",
#           'of' => "here"
#         }
#       }
#     end

#     it "should symbolize keys" do
#       hash = @simple_hash
#       test_hash hash
#       hash.should_not == @simple_hash
#     end

#     it "should symbolize keys recursively" do
#       hash = @deep_hash.symbolize_keys(true)
#       test_hash hash
#       hash.should_not == @deep_hash
#     end

#     it "should symbolize keys recursively and be destructive" do
#       hash = @deep_hash.symbolize_keys!(true)
#       test_hash hash
#       hash.should == @deep_hash
#     end
#   end
# end