require 'spec_helper'
describe DreiSchichtenModell do
  
  
  it "get perfect dsm mix" do
    


    # Angelstelter mit zwei kindern
    avatar1 = {
      :income             => 48000,
      :age                => 30,
      :taxclass           => 1,
      :churchtax          => true,
      :sozi_obligation    => true,
      :health_insurance   => 'g',
      :state_pension      => true,
      :children           => [1999,1980],
      :federal_state      => 'hh',
      :pension_height     => 1500
    }
    
    
    
    # freiberufler ohne kinder
    avatar2 = {
      :income             => 72000,
      :age                => 27,
      :taxclass           => 1,
      :churchtax          => false,
      :sozi_obligation    => false,
      :health_insurance   => 'p',
      :state_pension      => false,
      :children           => [],
      :federal_state      => 'be',
      :pension_height     => 3000
    }

    
    # Lehrer(Beamte) verheiratet mit einem kind
    avatar3 = {
      :income             => 36000,
      :age                => 35,
      :taxclass           => 1,
      :churchtax          => true,
      :sozi_obligation    => false,
      :health_insurance   => 'g',
      :state_pension      => true,      
      :children           => [1998],
      :federal_state      => 'be',
      :pension_height     => 1500
    }


    # Student 
    avatar4 = {
      :income             => 7000,
      :age                => 23,
      :taxclass           => 1,
      :churchtax          => false,
      :sozi_obligation    => false,
      :health_insurance   => 'g',
      :state_pension      => true,      
      :children           => [],
      :federal_state      => 'hh',
      :pension_height     => 1500
    }




    altersvorsorge = DreiSchichtenModell::AltersvorsorgeMix.new(avatar1)
    riester, bav, basis = altersvorsorge.bestmix

    p riester.inspect
    p bav.inspect
    p basis.inspect
  end
  
  
end
