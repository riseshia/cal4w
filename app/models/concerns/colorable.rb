# Colorable
module Colorable
  PALATTE = [
    '#F49AC2', '#CB99C9', '#C23B22',
    '#FFD1DC', '#DEA5A4', '#AEC6CF',
    '#77DD77', '#CFCFC4', '#B39EB5',
    '#FFB347', '#B19CD9', '#FF6961',
    '#03C03C', '#FDFD96', '#836953',
    '#779ECB', '#966FD6'
  ]

  def to_hex
    PALATTE[to_hex_with % PALATTE.size]
  end

  def to_hex_with
    self.id
  end
end