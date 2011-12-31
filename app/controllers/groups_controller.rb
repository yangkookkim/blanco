class GroupsController < ApplicationController
  def show
    @group_id = params[:id]
    @employee_id = params[:employee_id]
    @group = Group.find(@group_id)
    @posts = @group.posts
    @new_post = @group.posts.new
  end
end
