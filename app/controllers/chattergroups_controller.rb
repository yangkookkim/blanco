class ChattergroupsController < ApplicationController
  def show
    @chattergroup = Chattergroup.find(params[:id])
  end
end
