# rake hello_world
desc "remove all image files under public/uploaders/*/image"
task "remove_images" do            # rake task name.
	DELETEDIR = "#{Rails.root}/public/uploaders/"

	dirlist = Dir::glob(DELETEDIR + "**/").sort {
		 |a,b| b.split('/').size <=> a.split('/').size
	}

	dirlist.each {|d|
		 Dir::foreach(d) {|f|
		   File::delete(d+f) if ! (/\.+$/ =~ f)
		 }
		 Dir::rmdir(d)
	}
end
