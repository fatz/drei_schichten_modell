require 'investment'
class Riester
  
  attr_reader :anlage, :rendite, :zulage, :ablaufleistung, :eigenbeitrag, :gesamt_eigenbeitrag, :rente
  attr_writer :kinder, :verzinsung, :aufschubzeit, :rentengarantiefaktor, :beitrag_pa, :job_status

 
  def initialize(bruttojahreseinkommen)
    @bruttojahreseinkommen = bruttojahreseinkommen
    @maximalbeitrag = bruttojahreseinkommen/100*4 < 2100 ? bruttojahreseinkommen/100*4 : 2100
    @grundzulage = 154
    @kinder = []
    @kinderzulage = 0
    @zulage = 0
    @verzinsung   = 2.0
    @aufschubzeit = 1
    @rentengarantiefaktor = 36.51
    @eigenbeitrag = ideal_beitrag
  end


  def ideal_beitrag
    eigenbeitrag = @maximalbeitrag - @grundzulage - @kinderzulage
    return eigenbeitrag > 60 ? eigenbeitrag : 60
  end
  
  
  def versicherungskosten(ablaufleistung)
    @ablaufleistung = ablaufleistung
    kosten = Investment.new
    kosten.k0 = @ablaufleistung
    kosten.p = 12.0 # 12% kosten
    kosten.n = 1
    return kosten.kn_einfach - @ablaufleistung
  end


  def run
    # brechnung der kinder zulage.
    @kinder.each do |geburtsjahr|
      @kinderzulage += geburtsjahr < 2008 ? 185 : 300
    end

    # die gesamte zulage p.a.
    @zulage       =  @grundzulage + @kinderzulage
    
    # welche summe geht in die anlage p.a.
    @anlage       =  @maximalbeitrag + @zulage
    
    # berechnung der redite
    @rendite      =  (@zulage * 100 / @maximalbeitrag) + @verzinsung
    
    # was kostet mich das produkt efektiv. mit berucksichtigung der zulagen
    @gesamt_eigenbeitrag = @eigenbeitrag * @aufschubzeit
    
    # berechnung der ablaufleistung
    invest = Investment.new
    invest.p = @verzinsung
    invest.r = @anlage
    invest.n = @aufschubzeit
    @ablaufleistung = (invest.rn - versicherungskosten(invest.rn.to_i)).to_i 

    
    # fiktive berechnung der rente p.a.
    prozehntausend = @ablaufleistung/10000
    @rente = (prozehntausend*@rentengarantiefaktor)*12
  end
end




#riester = Riester.new(32000)
#riester.verzinsung = 6.0
#riester.beitrag_pa = 60
#riester.kinder = [1999,1980]#
#riester.aufschubzeit = 30
#riester.run
#puts riester.inspect



