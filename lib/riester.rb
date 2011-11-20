class Riester
  
  attr_reader :anlage, :rendite, :eigenbeitrag, :zulage, :ablaufleistung, :gesamt_eigenbeitrag, :rente
  attr_writer :partner, :kinder, :verzinsung, :aufschubzeit
 
  def initialize(bruttojahreseinkommen)
    @bruttojahreseinkommen = bruttojahreseinkommen
    @anlagebetrag = bruttojahreseinkommen/100*4 < 2100 ? bruttojahreseinkommen/100*4 : 2100
    @grundzulage = 154
    @partner = false
    @kinder = false
    @kinderzulage = 0
    @zulage = 0
    @verzinsung   = 2.0
    @aufschubzeit = 1
    @ablaufleistung = 0 
    @gesamt_eigenbeitrag = 0
  end


  
  def eigenbeitrag
    eigenbeitrag = @anlagebetrag - @grundzulage - @kinderzulage
    return eigenbeitrag > 60 ? eigenbeitrag : 60
  end
  
  

  def run
    
    @kinder.each do |geburtsjahr|
      @kinderzulage += geburtsjahr < 2008 ? 185 : 300 
    end

    @zulage       =  @grundzulage + @kinderzulage
    @anlage       =  @anlagebetrag + @zulage
    @eigenbeitrag =  eigenbeitrag
    @rendite      =  (@zulage*100/@anlagebetrag)+@verzinsung
    @gesamt_eigenbeitrag = @anlage*@aufschubzeit
        
    invest = Investment.new
    invest.p = @verzinsung
    invest.r = @anlage
    invest.n = @aufschubzeit   
    @ablaufleistung = invest.rn.to_i
  end





  
end
