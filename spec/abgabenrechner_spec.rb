require 'spec_helper'
describe Abgabenrechner do
  
  
  it "Simple API call with HASH feedback" do
    parameter = { :lzz => 1, :re4 => 2600000, :stkl => 1 }
    BMF::Abgabenrechner.new(parameter).hash
  end
  
  
end
