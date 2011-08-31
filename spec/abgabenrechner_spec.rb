require 'spec_helper'
describe Abgabenrechner do
  
  
  it "Simple API call with HASH feedback" do
    parameter = { :lzz => 1, :re4 => 2600000, :stkl => 1 }
    BMF::Abgabenrechner.new(parameter).hash
  end
  
  
  it "Simple API call with XML feedback" do
    parameter = { :lzz => 1, :re4 => 2600000, :stkl => 1 }
    BMF::Abgabenrechner.new(parameter).xml
  end
  
  
  
  it "API call with HASH feedback" do
    
    parameter = { 
      :lzz => 1, 
      :re4 => 2600000, 
      :stkl => 1, 
      :r => 1 
    }
    
    abgabenrechner = BMF::Abgabenrechner.new(parameter)
    puts abgabenrechner.ausgaben.inspect
    
  end
  
  
  
end