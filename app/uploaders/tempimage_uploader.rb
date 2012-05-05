class TempimageUploader < ImageUploader
  version :thumb do
    process :resize_to_fill => [50, 50]
  end

  version :icon do
    process :resize_to_fill => [100, 100]
  end
end
