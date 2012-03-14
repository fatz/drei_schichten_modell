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
          
         flex =                           Flex.new
         flex.flex_pa =                   @avatar_info.flex_beitrag_pa
         flex.verzinsung =                @avatar_info.verzinsung
         flex.aufschubzeit =              @avatar_info.aufschubzeit
         flex.rentengarantiefaktor =      @avatar_info.rentengarantiefaktor
         flex.run
         
        
         if @avatar_info.flex_wunsch == nil
           @empfehlung = false
         else
           @empfehlung = @avatar_info.flex_wunsch
         end

         
         return to_hash("flex", flex, @empfehlung)
       else
         puts 'es fehlen daten zur berechnung der Flexiblen Altersvorsorge'
       end
     end




     def riester
       if @avatar_info.kinder && 
          @avatar_info.verzinsung && 
          @avatar_info.aufschubzeit &&
          @avatar_info.job_status
              
         riester =                        Riester.new(@avatar_info.einkommen)
         riester.kinder =                 @avatar_info.kinder
         riester.beitrag_pa =             @avatar_info.riester_beitrag_pa if @avatar_info.riester_beitrag_pa
         riester.job_status =             @avatar_info.job_status
         riester.verzinsung =             @avatar_info.verzinsung
         riester.aufschubzeit =           @avatar_info.aufschubzeit
         riester.rentengarantiefaktor =   @avatar_info.rentengarantiefaktor
         riester.run
         
         
         if @avatar_info.riester_wunsch == nil
           @empfehlung = @avatar_info.grv ? true : false
         else
           @empfehlung = @avatar_info.riester_wunsch
         end
                           
         return to_hash("riester", riester, @empfehlung)
       else
         puts 'es fehlen daten zur berechnung der Riester Rente'
       end
     end







     def bav
       if @avatar_info.steuerklasse && 
          @avatar_info.bav_beitrag_pa && 
          @avatar_info.verzinsung && 
          @avatar_info.aufschubzeit
          
         
         bav =                            BetrieblicheAltersvorsorge.new(@avatar_info.einkommen)
         bav.steuerklasse =               @avatar_info.steuerklasse
         bav.bav_pa =                     @avatar_info.bav_beitrag_pa
         bav.verzinsung =                 @avatar_info.verzinsung
         bav.aufschubzeit =               @avatar_info.aufschubzeit
         bav.rentengarantiefaktor =       @avatar_info.rentengarantiefaktor
         bav.run
         
         
         if @avatar_info.bav_wunsch == nil
           @empfehlung = @avatar_info.pflichtversichert ? true : false
         else
           @empfehlung = @avatar_info.bav_wunsch
         end
         
         
         return to_hash("bav", bav, @empfehlung )
       else
         puts 'es fehlen daten zur berechnung der Betriebliche Altersvorsorge'
       end
     end





     def basis
       if @avatar_info.basis_beitrag_pa && 
          @avatar_info.steuerklasse && 
          @avatar_info.verzinsung && 
          @avatar_info.aufschubzeit

          basis =                         Basis.new(@avatar_info.einkommen)
          basis.basis_pa =                @avatar_info.basis_beitrag_pa
          basis.steuerklasse =            @avatar_info.steuerklasse
          basis.verzinsung =              @avatar_info.verzinsung
          basis.aufschubzeit =            @avatar_info.aufschubzeit
          basis.rentengarantiefaktor =    @avatar_info.rentengarantiefaktor
          basis.run
          
          if @avatar_info.basis_wunsch == nil
            @empfehlung = @avatar_info.grv ? false : true
          else
            @empfehlung = @avatar_info.basis_wunsch
          end
          
          return to_hash("basis", basis, @empfehlung)
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
          grv.grv_pa =                    @avatar_info.grv_rente_pa ? @avatar_info.grv_rente_pa : 0
          grv.run

          @empfehlung =                   @avatar_info.grv ? true : false
          
          return to_hash("grv", grv, @empfehlung)
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
          rente:                  produkt.rente.to_i
        }
     end



     def produkte
       return  flex, riester, bav, basis, grv
     end
     
     
  end
  

  
  
  
end
