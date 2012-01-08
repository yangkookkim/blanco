class GroupsController < ApplicationController
  def show
    @group_id = params[:id]
    @employee_id = params[:employee_id]
    @group = Group.find(@group_id)
    #@lastpost_id = @group.posts.last.id
    @posts = @group.posts.sort.reverse # Get posts sorted by descending order
    @new_post = @group.posts.new
  end
end
