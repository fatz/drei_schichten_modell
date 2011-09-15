require "drei_schichten_modell/version"
require "betriebliche_altersvorsorge"
require "riester"
require "basis"

module DreiSchichtenModell
  
  class AltersvorsorgeMix

     def initialize(avatar_info)
       @avatar_info = avatar_info
       @riester = false
       @bav     = false
       @basis   = false
     end


     def riester
       riester = Riester.new(@avatar_info[:income])
       riester.kinder = @avatar_info[:children]
       riester.run
       return riester
     end



     def bav
       bav = BetrieblicheAltersvorsorge.new(@avatar_info[:income])
       bav.kinder = @avatar_info[:children]
       bav.steuerklasse = @avatar_info[:taxclass]
       bav.run
       return bav
     end


     def basis
       basis = Basis.new(@avatar_info[:income])
       basis.run
       return basis
     end



     def bestmix
       @riester = @avatar_info[:state_pension] ? riester : false
       @bav     = @avatar_info[:sozi_obligation] ? bav : false
       @basis   = @avatar_info[:state_pension] ? false : basis

       return  @riester, @bav, @basis
     end





  end

  
  








end
