class GroupsController < ApplicationController
  layout 'employees_groups_posts'
  def instant_search_show_result
    respond_to do |format|
      format.js   {render :layout => false}
    end    
  end
  
  def show_js
    # This action is called from javascript_include_tag in groups/show.
    # Reason why doing .delete(".js") is that javascript_include_tag automatically add .js at the end of url.
    employee_id = params[:employee_id].delete(".js")
    group_id = params[:id].delete(".js")
    @employee = Employee.find_by_id(employee_id)
    @group = Group.find_by_id(group_id)    
    respond_to do |format|
      format.js   {render :layout => false}
    end
  end
  
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
    #@imagepost = Post.find(300)
    @employee = Employee.find_by_id(params[:employee_id])
    @group = Group.find_by_id(params[:id])
    @groups = @employee.groups
    @posts = @group.posts.sort.reverse # Get posts sorted by descending order
    @new_post = @group.posts.new
    puts "DEBUG"
    cookie_val = Hash.new
    @groups.each {|g|
      cookie_val[g.name] = "0" # I want to pass g.id to the key of cookie_val, but jquery does not understand this for some reason. So use g.name, instead. 
    }
    cookies[:unread_posts] = {:value => cookie_val.to_json }
  end
end
