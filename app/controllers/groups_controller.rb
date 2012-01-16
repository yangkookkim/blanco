class GroupsController < ApplicationController
  layout 'employees_groups_posts'

  def instant_search
    @results = Employee.find(:all, :conditions=>["name like ?", "%#{params[:q]}%"])
    render :json => @results.to_json
  end
    
  def search_employees
    @employee = Employee.find_by_id(params[:employee_id])
    @groups = @employee.groups
    @new_group = Group.new
    
    if params[:search_string].empty?
       @employees_matched = nil
    else
       @employees_matched = Employee.find(:all, :conditions=>["name like ?", "%#{params[:search_string]}%"])
    end
    render :action => 'new' 
  end
  
  def create
  		puts "DEBUG"
  		puts params[:members].class
    @employee = Employee.find_by_id(1)
    @groups = @employee.groups
    @new_group = @employee.groups.new(params[:group])
    if @groups << @new_group
      redirect_to(employee_path(@employee.id))
    end
  end
  
  def new
    @employee = Employee.find_by_id(params[:employee_id])
    @groups = @employee.groups
    @new_group = Group.new
  end
  
  def show
    @employee = Employee.find_by_id(params[:employee_id])
    @group = Group.find_by_id(params[:id])
    @groups = @employee.groups
    @posts = @group.posts.sort.reverse # Get posts sorted by descending order
    @new_post = @group.posts.new
  end
end
