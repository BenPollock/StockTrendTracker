module ClosesHelper

  #Get the next day case
  def nextDay(id)
    @next_day = Close.find(id - 1)
  end

end
