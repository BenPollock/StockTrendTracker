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

      #To fix bug where it doesn't work with negative start
      #and positive end, split into separate queries
     if @p_start < 0 && @p_end > 0
        @case1 = Close.find(:all, conditions:["date between ? and ? AND 
          ((close-open)/open * 100) between ? and -0.1",
          @f_start, @f_end, @p_start])
        @case2 = Close.find(:all, conditions:["date between ? and ? AND
          ((close-open)/open * 100) between 0.1 and ?",
          @f_start, @f_end, @p_end])

        #Combine them into the cases attribute
        @cases = []
        @case1.each do |item1|
          @cases << item1
        end
        @case2.each do |item2|
          @cases << item2
        end
        #Otherwise, do it as normal
      else
        @cases = Close.find(:all, conditions:["date between ? and ? AND 
          ((close-open)/open * 100) between ? and ?",
          @f_start, @f_end, @p_start, @p_end])
      end

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
      @total = (@total/@count) * 100

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
