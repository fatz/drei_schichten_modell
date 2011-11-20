class Flex
  
  attr_reader :anlage, :rendite, :eigenbeitrag, :ablaufleistung, :zulage, :gesamt_eigenbeitrag, :rente
  attr_writer :verzinsung, :flex_pa, :aufschubzeit
  
  def initialize
    @verzinsung   = 2.0
    @aufschubzeit = 1
    @ablaufleistung = 0
    @zulage = 0
    @flex_pa = 0
    @gesamt_eigenbeitrag = 0
  end

  
  

  def run
    invest = Investment.new
    invest.p = @verzinsung
    invest.r = @flex_pa
    invest.n = @aufschubzeit
    
    @ablaufleistung =     invest.rn.to_i
    @anlage         =     @flex_pa
    @eigenbeitrag   =     @flex_pa
    @rendite        =     @verzinsung
    @gesamt_eigenbeitrag = @anlage*@aufschubzeit
  end




  
end
