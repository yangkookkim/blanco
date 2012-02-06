class ApplicationController < ActionController::Base
  protect_from_forgery
  def instant_search
    if params[:query_type] == "employees"
      @results = Employee.find(:all, :conditions=>["name like ?", "%#{params[:q]}%"]) #exclude myself from query
      render :json => @results.to_json
    end
  end
end
