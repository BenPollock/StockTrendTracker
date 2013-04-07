class Close < ActiveRecord::Base
  attr_accessible
  validates :close, presence: true
  validates :date, presence: true

  #Get the next day
=begin
  def self.nextDay(id)

  	#id to string
  	begin
  		idint = Integer(id)
  	rescue
  		idint = 0

  	idint = idint + 1
  	Close.find(idint)
  end
=end
end
