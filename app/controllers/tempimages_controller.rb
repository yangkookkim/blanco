class TempimagesController < ApplicationController
  def create
    image = Tempimage.new(params[:post])
    if image.save
      #    "render :json => @post" does not work with jQuery.upload plugin.
      #    # If you do, jQuery upload cannot parse the response as json.
      #    # Only render:text => object.to_json works.
      render :text => image.to_json
    else
      raise "Failed to create tempimage"
    end
  end
end
