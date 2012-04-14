class RestaurantUploader < ImageUploader
  version :thumb do
    process :resize_to_fill => [40, 40]
  end

  version :icon do
    process :resize_to_fill => [100, 100]
  end
end
