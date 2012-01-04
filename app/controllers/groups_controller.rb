class GroupsController < ApplicationController
  def checkupdate_ajax
    @group = Group.find(params[:id])
    @lastpost_id = params[:lastpost_id].to_i
    @newestpost_id = @group.posts.last.id
    if @lastpost_id < @newestpost_id
      id = @lastpost_id + 1
      new_posts = []
      while @newestpost_id >= id
        # Use find_by_id since it returns nil if object of id does not exist while find creates ActiveRecordNotFound exception
        new_post = @group.posts.find_by_id(id)
        new_posts << new_post if new_post
        id = id + 1
      end
      render :json => {:new_posts => new_posts}
    elsif
      render :json => {:updated => 0, :updated_at => @updated_at}
    end
  end
  
  def show
    @group_id = params[:id]
    @employee_id = params[:employee_id]
    @group = Group.find(@group_id)
    @lastpost_id = @group.posts.last.id
    @posts = @group.posts.sort.reverse # Get posts sorted by descending order
    @new_post = @group.posts.new
  end
end
