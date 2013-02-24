class PointCoordinate < ActiveRecord::Base
  attr_accessible :MAC, :signal_str
  belongs_to :location
end
