class ClosesController < ApplicationController
  def home

  	#get value from forms
  	@index = params[:index]
  	@id = params[:id]


  	#find the case(s)
  	begin
  		@cases = Close.find(@id)
  	rescue
  		@cases = false
  	end

  	#get next day
  	#@nextcase = Close.nextDay(@id)

  end









end
