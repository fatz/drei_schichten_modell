module Renteneintrittsalter
  
  def renteneintrittsalter
    @regelaltersrente = 67
    case @geburtsjahr
      when 1946..1957 then @regelaltersrente = 65
      when 1958..1963 then @regelaltersrente = 66
      when 1964..Time.now.year then @regelaltersrente = 67
    end
    return @regelaltersrente
  end
  
end

