class HS100 < Thing

  def turn_on
    system "pyhs100 --ip #{address} --plug on"
  end

  def turn_off
    system "pyhs100 --ip #{address} --plug off"
  end

end