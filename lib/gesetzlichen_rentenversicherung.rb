# http://www.focus.de/finanzen/altersvorsorge/rente/tid-8425/rentenrechner_aid_231122.html

class GesetzlichenRentenversicherung 
  
  attr_reader :anlage, :rendite, :eigenbeitrag, :ablaufleistung, :zulage, :gesamt_eigenbeitrag, :rente
  attr_writer :grv_pa, :aufschubzeit, :berufseinstieg, :geburtsjahr, :renteneintrittsalter, :bundesland
  
  def initialize(bruttojahresgehalt)
    @renteneintrittsalter = 67
    @geburtsjahr          = 0
    @brutto_pa 	          = bruttojahresgehalt
    @verzinsung           = 2.0
    @grv_pa               = 0
  end
  

  def run
    @rentenanwartschaftszeit  = (@geburtsjahr + @renteneintrittsalter) - @berufseinstieg
    @entgeltpunkte        = 1.0*@rentenanwartschaftszeit
    @zugangsfaktor        = 1
    @rentenartfaktor      = 1
    @rentenwert           = 26.56
    
    @rendite              =  @verzinsung
    @eigenbeitrag         = ((@brutto_pa/100)*9.95)/12
    @gesamt_eigenbeitrag  = ((@brutto_pa/100)*9.95)*@rentenanwartschaftszeit
    if @grv_pa == 0
      @rente = @entgeltpunkte*@zugangsfaktor*@rentenartfaktor*@rentenwert
    else
      @rente = @grv_pa/12
    end
  end

end

