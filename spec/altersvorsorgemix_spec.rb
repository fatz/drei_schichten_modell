require 'spec_helper'
describe DreiSchichtenModell do
  
  
  it "get perfect dsm mix" do
    


    # Angelstelter mit zwei kindern
    avatar1 = {
      :income                => 48000,
      :age                   => 30,
      :taxclass              => 1,
      :churchtax             => true,
      :compulsory_insurance    => true,
      :health_insurance      => 'g',
      :state_pension         => true,
      :children              => [2000],
      :federal_state         => 'hh',
      :pension_height        => 1500,
      :pensionable_age       => 67,
      :interest              => 6
    }
    
    
    
    # freiberufler ohne kinder
    avatar2 = {
      :income             => 72000,
      :age                => 27,
      :taxclass           => 1,
      :churchtax          => false,
      :compulsory_insurance    => false,
      :health_insurance   => 'p',
      :state_pension      => false,
      :children           => [],
      :federal_state      => 'be',
      :pension_height     => 3000,
      :pensionable_age    => 67,
      :interest           => 8


    }

    
    # Lehrer(Beamte) verheiratet mit einem kind
    avatar3 = {
      :income             => 36000,
      :age                => 40,
      :taxclass           => 1,
      :churchtax          => true,
      :compulsory_insurance    => false,
      :health_insurance   => 'g',
      :state_pension      => true,      
      :children           => [1998],
      :federal_state      => 'be',
      :pension_height     => 1500,
      :pensionable_age    => 67,
      :interest           => 3
    }


    # Student 
    avatar4 = {
      :income             => 5000,
      :age                => 23,
      :taxclass           => 1,
      :churchtax          => false,
      :compulsory_insurance    => false,
      :health_insurance   => 'p',
      :state_pension      => true,  
      :children           => [],
      :federal_state      => 'hh',
      :pension_height     => 1500,
      :pensionable_age    => 67,
      :interest           => 8
    }


    # Student
    avatar5 = {
      :income             => 28600,
      :age                => 23,
      :taxclass           => 1,
      :churchtax          => true,
      :compulsory_insurance    => true,
      :health_insurance   => 'g',
      :state_pension      => true,
      :children           => [],
      :federal_state      => 'hh',
      :pension_height     => 1500,
      :pensionable_age    => 67,
      :interest           => 8
    }


    puts avatar = avatar3



    altersvorsorge = DreiSchichtenModell::AltersvorsorgeMix.new( avatar )
    versicherungskosten = 10000

    riester, bav, basis = altersvorsorge.bestmix

    @gesamt_anlage = 0
    @gesamt_zulage = 0
    @gesamt_eigenbeitrag = 0
    @gesamt_ablaufleistung = 0
      
    [riester, bav, basis].each do |product|
      if product
        puts product.inspect
        @gesamt_anlage += product.anlage
        @gesamt_zulage += product.zulage
        @gesamt_eigenbeitrag += product.eigenbeitrag
        @gesamt_ablaufleistung += altersvorsorge.ablaufleistung(product.anlage)
      end
    end

    puts @gesamt_anlage
    puts @gesamt_zulage
    puts @gesamt_eigenbeitrag
    puts @gesamt_ablaufleistung-versicherungskosten
    
    puts '-- -- --'

    # jahresbeitrag, zeitraum, verzinsung
    invest = Investment.new(@gesamt_anlage, avatar[:pensionable_age]-avatar[:age], avatar[:interest])
    endsumme = invest.kapitelanwuchs.last
    puts "endkapital mit #{avatar[:pensionable_age]} nach #{avatar[:pensionable_age]-avatar[:age]} jahren: #{endsumme} euro"
    
    rentenfaktor = 36.51 # pro 10.000 euro

    puts "Rente mit #{ 36.51*endsumme.to_f/10000 } "

  end
  



end
