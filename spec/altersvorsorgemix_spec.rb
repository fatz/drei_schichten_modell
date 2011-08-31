require 'spec_helper'
describe DreiSchichtenModell do
  
  
  it "get perfect dsm mix" do
    

    avatar_info = { 
      :name               => 'ich',
      :income             => 48000,
      :age                => 30,
      :taxclass           => 1,
      :churchtax          => false,
      :sozi               => true,
      :health_insurance   => 'grv',
      :children           => [1999,1980],
      :federal_state      => 'hamburg',
      :pension            => 1500,
      :pension_age        => 67,
      :interest_charges   => 8
    }


    DreiSchichtenModell::AltersvorsorgeMix.new(avatar_info)
  end
  
  
end
