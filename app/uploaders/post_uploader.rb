# coding: utf-8
class PostUploader < ImageUploader
  process :resize_to_fill => [100, 100]

  version :thumb do
    process :resize_to_fill => [50, 50]
  end
end