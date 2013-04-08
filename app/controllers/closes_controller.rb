class ClosesController < ApplicationController
  def home

  	#get value from forms
  	@index = params[:index]
  	@id = params[:id]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @low_range = params[:low_range]
    @high_range = params[:high_range]

    @f_start = Date.parse(@start_date)
    @f_end = Date.parse(@end_date)

    @p_start = @low_range.to_f
    @p_end = @high_range.to_f

    @cases_nextday = []

  	begin
      #Find the cases
      @cases = Close.find(:all, conditions:["date between ? and ? AND 
        ((close-open)/open * 100) between ? and ?",
        @f_start, @f_end, @p_start, @p_end])

      #Find the next day cases
      @cases.each do |case_instance|
        @cases_nextday.push(Close.find(case_instance.id - 1))
      end

      #Get the average
      @total = 0
      @count = 0
      @cases_nextday.each do |nextday_instance|
        instance = (nextday_instance.close-nextday_instance.open)/(nextday_instance.open)
        @total = @total + instance
        @count = @count + 1
      end
      @total = @total/@count

      if(@cases.empty?)
         @cases = false
      end
  	rescue
  		@cases = false
  	end

  	#get next day
  	#@nextcase = Close.nextDay(@id)

  end










end
