require "drei_schichten_modell/version"
require "betriebliche_altersvorsorge"
require "riester"
require "basis"
require "beitragsbemessungsgrenze"

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
       riester.verzinsung = @avatar_info[:interest_rate]
       riester.aufschubzeit = @avatar_info[:paytime]
       riester.run
       return riester
     end



     def bav
       bav = BetrieblicheAltersvorsorge.new(@avatar_info[:income])
       bav.kinder = @avatar_info[:children]
       bav.steuerklasse = @avatar_info[:taxclass]
       bav.bav_pa = @avatar_info[:bav_pa] if @avatar_info[:bav_pa]
       bav.verzinsung = @avatar_info[:interest_rate]
       bav.aufschubzeit = @avatar_info[:paytime]
       bav.run
       return bav
     end


     def basis
       basis = Basis.new(@avatar_info[:income])
       basis.basis_pa = @avatar_info[:basis_pa]
       basis.steuerklasse = @avatar_info[:taxclass]
       basis.verzinsung = @avatar_info[:interest_rate]
       basis.aufschubzeit = @avatar_info[:paytime]
       basis.run
       return basis
     end



     def bestmix
       @riester = @avatar_info[:state_pension] ? riester : false
       @bav     = @avatar_info[:compulsory_insurance] ? bav : false
       @basis   = @avatar_info[:state_pension] ? false : basis

       return  @riester, @bav, @basis
     end
  end
  

  
  
  
end
