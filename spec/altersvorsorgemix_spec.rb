require 'spec_helper'
describe DreiSchichtenModell do
  
  
  it "get perfect dsm mix" do
    


    # Angelstelter mit zwei kindern
    avatar1 = {
      :income                => 48000,
      :age                   => 30,
      :taxclass              => 1,
      :churchtax             => true,
      :obligation_insured    => true,
      :health_insurance      => 'g',
      :state_pension         => true,
      :children              => [1999,1980],
      :federal_state         => 'hh',
      :pension_height        => 1500,
      :pensionable_age       => 67
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
      :pension_height     => 3000,
      :pensionable_age       => 67

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
      :pension_height     => 1500,
      :pensionable_age       => 67
    
    }


    # Student 
    avatar4 = {
      :income             => 5000,
      :age                => 23,
      :taxclass           => 1,
      :churchtax          => false,
      :sozi_obligation    => false,
      :health_insurance   => 'p',
      :state_pension      => true,  
      :children           => [],
      :federal_state      => 'hh',
      :pension_height     => 1500,
      :pensionable_age       => 67

    }


    # Angelstelter mit zwei kindern
    avatar5 = {
      :income             => 28600,
      :age                => 23,
      :taxclass           => 1,
      :churchtax          => true,
      :sozi_obligation    => true,
      :health_insurance   => 'g',
      :state_pension      => true,
      :children           => [],
      :federal_state      => 'hh',
      :pension_height     => 1500,
      :pensionable_age       => 67
    }


    avatar = avatar2



    altersvorsorge = DreiSchichtenModell::AltersvorsorgeMix.new( avatar )
    riester, bav, basis = altersvorsorge.bestmix

    @gesamt_anlage = 0
    @gesamt_zulage = 0
    @gesamt_eigenbeitrag = 0

    [riester, bav, basis].each do |item|
      if item
        puts item.inspect
        @gesamt_anlage += item.anlage
        @gesamt_zulage += item.zulage
        @gesamt_eigenbeitrag += item.eigenbeitrag        
      end
    end

    puts @gesamt_anlage
    puts @gesamt_zulage
    puts @gesamt_eigenbeitrag

    puts '-- -- --'

    # jahresbeitrag, zeitraum, verzinsung
    invest = Investment.new(@gesamt_anlage, avatar[:pensionable_age]-avatar[:age], 8)
    endsumme = invest.kapitelanwuchs.last
    puts "endkapital mit #{avatar[:pensionable_age]} nach #{avatar[:pensionable_age]-avatar[:age]} jahren: #{endsumme} euro"
    
  end
  



end
