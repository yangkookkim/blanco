class ApplicationController < ActionController::Base
  protect_from_forgery
  def instant_search
    if params[:query_type] == "employees"
      @results = Employee.find(:all, :conditions=>["name like ?", "%#{params[:q]}%"]) #exclude myself from query
      @results.each {|e|
      }
      puts "DEBUG"
      puts @results.to_json
      render :json => @results.to_json
    end
  end
end
