require 'spec_helper'
describe DreiSchichtenModell do
  
  
  it "get perfect dsm mix" do
    
    avatar = {
      einkommen:             27600,
      geburtsjahr:           1980,
      steuerklasse:          1,
      kirchensteuer:         false,
      grv:                   true,
      grv_rente_pa:          600*12,
      wunschrente_pa:        2000*12,
      pflichtversichert:     true,
      krankenversicherung:   'g',
      kinder:                [1999,2002],
      bundesland:            'hh',
      verzinsung:            5.0,
      renteneintrittsalter:  67,
      aufschubzeit:          30,
      bav_beitrag_pa:        600 
    }
    
    
    altersvorsorge = DreiSchichtenModell::AltersvorsorgeMix.new( avatar )

    altersvorsorge.produkte.each do |product|
       puts product.inspect if product
    end



  end
  



end


