require 'rspec'
require 'recursion_problems'

describe "#sum_recur" do
  #Problem 1: You have array of integers. Write a recursive solution to find
  #the sum of the integers.
  
  it "returns 0 if blank array" do
    sum_recur([]) == 0
  end

  it "returns the sum of all numbers in array" do
    sum_recur([1, 3, 5, 7, 9, 2, 4, 6, 8]).should == 45
  end

  it "should not modify original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    sum_recur(original)
    original.should == [1, 3, 5, 7, 9, 2, 4, 6, 8]
  end

  it "calls itself recursively" do
    # this should enforce you calling your method recursively.
    
    should_receive(:sum_recur).at_least(:twice).and_call_original
    sum_recur([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end
end

describe "#includes?" do
  #Problem 2: You have array of integers. Write a recursive solution to
  #determine whether or not the array contains a specific value.

  it "returns false if target isn't found" do
    includes?([1, 3, 5, 7, 9, 2, 4, 6, 8], 11).should == false
  end

  it "returns true if target isn't found" do
    includes?([1, 3, 5, 7, 9, 2, 4, 6, 8], 9).should == true
  end

  it "should not modify original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    includes?(original, 9)
    original.should == [1, 3, 5, 7, 9, 2, 4, 6, 8]
  end

  it "calls itself recursively" do    
    should_receive(:includes?).at_least(:twice).and_call_original
    includes?([1, 3, 5, 7, 9, 2, 4, 6, 8], 9)
  end
end

describe "#num_occur" do
  #Problem 3: You have an unsorted array of integers. Write a recursive
  #solution to count the number of occurrences of a specific value.

  it "returns number of times the target occurs in the array" do
    num_occur([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6], 5).should == 4
  end

  it "returns zero if target doesn't occur" do
    num_occur([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6], 13).should == 0
  end

  it "should not modify original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    num_occur(original, 9)
    original.should == [1, 3, 5, 7, 9, 2, 4, 6, 8]
  end

  it "calls itself recursively" do    
    should_receive(:num_occur).at_least(:twice).and_call_original
    num_occur([1, 3, 5, 7, 9, 2, 4, 6, 8], 9)
  end
end

describe "#add_to_twelve?" do
  #Problem 4: You have array of integers. Write a recursive solution to
  #determine whether or not two adjacent elements of the array add to 12.

  it "returns true if two adjacent numbers add to twelve" do
    add_to_twelve?([1, 1, 2, 3, 4, 5, 7, 4, 5, 6, 7, 6, 5, 6]).should == true
  end

  it "returns false if target doesn't occur" do
    add_to_twelve?([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6]).should == false
  end

  it "should not modify original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    add_to_twelve?(original)
    original.should == [1, 3, 5, 7, 9, 2, 4, 6, 8]
  end

  it "calls itself recursively" do    
    should_receive(:add_to_twelve?).at_least(:twice).and_call_original
    add_to_twelve?([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end
end

describe "#sorted?" do
  #Problem 5: You have array of integers. Write a recursive solution to
  #determine if the array is sorted.

  it "returns true if array has only one value" do
  sorted?([1]).should == true
  end
  
  it "returns [] if array is empty" do
    sorted?([]).should == []
  end
  
  it "returns true if array is sorted" do
    sorted?([1, 2, 3, 4, 4, 5, 6, 7]).should == true
  end

  it "returns false if array is not sorted" do
    sorted?([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6]).should == false
  end

  it "should not modify original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    sorted?(original)
    original.should == [1, 3, 5, 7, 9, 2, 4, 6, 8]
  end

  it "calls itself recursively" do    
    should_receive(:sorted?).at_least(:twice).and_call_original
    sorted?([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end
end

describe "#reverse" do
  #Problem 6: Write the code to give the value of a number after it is
  #reversed. (Don't use any #reverse methods!)

  it "returns same number if only one digit" do
    reverse(1).should == 1
  end

  it "returns reversed number if more than one digit" do
    reverse(12345).should == 54321
  end

  it "should not modify original number" do
    original = 123456
    reverse(original)
    original.should == 123456
  end

  it "calls itself recursively" do    
    should_receive(:reverse).at_least(:twice).and_call_original
    reverse(123456)
  end
end