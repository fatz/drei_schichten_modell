class Riester
  
  attr_reader :anlage, :rendite, :eigenbeitrag, :zulage, :ablaufleistung
  attr_writer :partner, :kinder, :verzinsung, :aufschubzeit
 
  def initialize(bruttojahreseinkommen)
    @bruttojahreseinkommen = bruttojahreseinkommen
    @anlagebetrag = bruttojahreseinkommen/100*4 < 2100 ? bruttojahreseinkommen/100*4 : 2100
    @grundzulage = 154
    @partner = false
    @kinder = false
    @kinderzulage = 0
    @zulage = 0
    @verzinsung   = 2
    @aufschubzeit = 1
    @ablaufleistung = 0 
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
    @rendite      =  @zulage*100/@anlagebetrag
    
    invest = Investment.new
    invest.p = @verzinsung.to_f
    invest.r = @anlage
    invest.n = @aufschubzeit   
    @ablaufleistung = invest.rn.to_i
  end





  
end
