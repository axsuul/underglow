require 'spec_helper'

describe "Array" do
  describe '#bucketize' do
    it "splits array into number of buckets" do
      bucketized = [4, 5, 6, 7].bucketize(2)
      bucketized.should == [[4, 5], [6, 7]]
    end

    it "splits array into buckets with uneven counts if necessary" do
      bucketized = [4, 5, 6, 7, 8].bucketize(3)
      bucketized.should == [[4, 5], [6, 7], [8]]
    end

    it "works with just one bucket" do
      bucketized = [4, 5, 6, 7].bucketize(1)
      bucketized.should == [[4, 5, 6, 7]]
    end

    it "can handles empty buckets" do
      bucketized = [4, 5, 6, 7].bucketize(5)
      bucketized.should == [[4], [5], [6], [7], []]
    end

    it "returns array if no buckets" do
      bucketized = [4, 5, 6, 7].bucketize(0)
      bucketized.should == [4, 5, 6, 7]
    end

    it "raises argument error if not given an integer" do
      lambda { [4, 5, 6].bucketize("foo") }.should raise_error(ArgumentError)
    end
  end
end