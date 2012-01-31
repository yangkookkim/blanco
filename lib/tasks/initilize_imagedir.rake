# rake hello_world
desc "remove all image files under public/uploaders/*/image"
task "remove_images" do
	FileUtils.rm_r( Dir.glob( "#{Rails.root}/public/uploads/*" ), {:force=>true} )
end
