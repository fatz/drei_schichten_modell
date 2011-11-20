require "drei_schichten_modell/version"

require "flex"
require "riester"
require "betriebliche_altersvorsorge"
require "basis"
require "gesetzlichen_rentenversicherung"

require "beitragsbemessungsgrenze"
require "investment"


module DreiSchichtenModell
  

  
  class AltersvorsorgeMix

     def initialize(avatar_info)
       @avatar_info = avatar_info
     end




     def flex
       if @avatar_info.verzinsung && 
          @avatar_info.aufschubzeit
          
         flex =                Flex.new
         flex.flex_pa =        @avatar_info.flex_beitrag_pa
         flex.verzinsung =     @avatar_info.verzinsung
         flex.aufschubzeit =   @avatar_info.aufschubzeit
         flex.run
         
         empfehlung =           false
         
         return to_hash("Flexible Altersvorsorge", flex, empfehlung)
       else
         puts 'es fehlen daten zur berechnung der Flexiblen Altersvorsorge'
       end
     end




     def riester
       if @avatar_info.kinder && 
          @avatar_info.verzinsung && 
          @avatar_info.aufschubzeit
          
         riester =                Riester.new(@avatar_info.einkommen)
         riester.kinder =         @avatar_info.kinder
         riester.verzinsung =     @avatar_info.verzinsung
         riester.aufschubzeit =   @avatar_info.aufschubzeit
         riester.run
         
         empfehlung =             @avatar_info.grv ? true : false
         
         return to_hash("Riester Rente", riester, empfehlung)
       else
         puts 'es fehlen daten zur berechnung der Riester Rente'
       end
     end







     def bav
       if @avatar_info.steuerklasse && 
          @avatar_info.bav_beitrag_pa && 
          @avatar_info.verzinsung && 
          @avatar_info.aufschubzeit
          
         
         bav =                    BetrieblicheAltersvorsorge.new(@avatar_info.einkommen)
         bav.steuerklasse =       @avatar_info.steuerklasse
         bav.bav_pa =             @avatar_info.bav_beitrag_pa
         bav.verzinsung =         @avatar_info.verzinsung
         bav.aufschubzeit =       @avatar_info.aufschubzeit
         bav.run
         
         empfehlung =             @avatar_info.pflichtversichert ? true : false
         
         return to_hash("Betriebliche Altersvorsorge", bav, empfehlung)
       else
         puts 'es fehlen daten zur berechnung der Betriebliche Altersvorsorge'
       end
     end





     def basis
       if @avatar_info.basis_beitrag_pa && 
          @avatar_info.steuerklasse && 
          @avatar_info.verzinsung && 
          @avatar_info.aufschubzeit

          basis =                 Basis.new(@avatar_info.einkommen)
          basis.basis_pa =        @avatar_info.basis_beitrag_pa
          basis.steuerklasse =    @avatar_info.steuerklasse
          basis.verzinsung =      @avatar_info.verzinsung
          basis.aufschubzeit =    @avatar_info.aufschubzeit
          basis.run
          
          empfehlung =            @avatar_info.grv ? false : true
          
          return to_hash("Ruerup-Rente", basis, empfehlung)
        else
          puts 'es fehlen daten zur berechnung der Ruerup-Rente'
      end
     end
     
     
     
     
     def grv
       if @avatar_info.renteneintrittsalter && 
          @avatar_info.geburtsjahr &&
          @avatar_info.berufseinstieg && 
          @avatar_info.bundesland

          grv =                           GesetzlichenRentenversicherung.new(@avatar_info.einkommen)
          grv.renteneintrittsalter =      @avatar_info.renteneintrittsalter
          grv.geburtsjahr =               @avatar_info.geburtsjahr
          grv.bundesland =                @avatar_info.bundesland
          grv.berufseinstieg =            @avatar_info.berufseinstieg
          grv.grv_pa =                    @avatar_info.grv_rente_pa
          grv.run
          
          empfehlung =                    true
          
          return to_hash("gesetzliche Rentenversicherung", grv, empfehlung)
        else
          puts 'es fehlen daten zur berechnung der gesetzlichen Rentenversicherung'
      end
     end

     
     
     
     def to_hash(name, produkt, empfehlung)

        {
          empfehlung:             empfehlung,
          typ:                    name, 
          anlage:                 produkt.anlage, 
          rendite:                produkt.rendite,
          zulage:                 produkt.zulage,
          eigenbeitrag:           produkt.eigenbeitrag,
          gesamt_eigenbeitrag:    produkt.gesamt_eigenbeitrag,
          ablaufleistung:         produkt.ablaufleistung,
          rente:                  produkt.rente
        }
     end



     def produkte
       return  flex, riester, bav, basis
     end
     
     
  end
  

  
  
  
end
