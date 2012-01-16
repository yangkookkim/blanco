class GroupsController < ApplicationController
  layout 'employees_groups_posts'

  def instant_search
    @results = Employee.find(:all, :conditions=>["name like ? and not name like ?", "%#{params[:q]}%", "%#{params[:m]}%"]) #exclude myself from query
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
    group_members = []
    group_members = params[:group_members]
    myid = params[:myid]
    @employee = Employee.find_by_id(myid)
    @groups = @employee.groups
    @new_group = @employee.groups.new(params[:group])
    group_members.each do |m|
      @emp = Employee.find_by_name(m)
      @new_group.employees << @emp
    end
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
