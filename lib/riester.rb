class Riester
  
  attr_reader :anlage, :zulage, :rendite, :eigenbeitrag
  attr_writer :partner, :partner, :partner_rentenversicherungspflichtig, :kinderzulage

 
  def initialize(bruttojahreseinkommen)
    @bruttojahreseinkommen = bruttojahreseinkommen
    @anlagebetrag = bruttojahreseinkommen/100*4 < 2100 ? bruttojahreseinkommen/100*4 : 2100
    @grundzulage = 154
    @partner = false
    @partner_rentenversicherungspflichtig = false
    @kinderzulage = 0
    @zulage = 0
  end


  def kinder(geburtsjahre)
    geburtsjahre.each do |geburtsjahr|
      @kinderzulage += geburtsjahr < 2008 ? 185 : 300 
    end
  end

  
  def eigenbeitrag
    eigenbeitrag = @anlagebetrag - @grundzulage - @kinderzulage

    return eigenbeitrag > 60 ? eigenbeitrag : 60
 
  end
  
  
  def rendite
    zulage*100/@anlagebetrag
  end
  
  def zulage
    @grundzulage + @kinderzulage
  end
  
  def anlage
    @anlagebetrag+zulage
  end

  
end
