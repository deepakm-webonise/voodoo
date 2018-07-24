class Job < ActiveRecord::Base
  belongs_to :user
  serialize :actions, JSON

  require 'rmagick'
  include Magick

  def process(actions)
    file_name = File.basename(source_url)
    update_attributes(
      destination_url: "localhost:3000/api/v1/jobs/#{id}/#{file_name}")
    image = ImageList.new(source_url)
    actions.each do |operation, values|
      values = values.to_s.split(/x|:/i) if values
      if values
        image = image.send(operation, *values.map(&:to_i))
      else
        image = image.send(operation)
      end
    end
    FileUtils.mkdir_p("#{Rails.root}/public/jobs/#{id}") unless
      Dir.exist?("#{Rails.root}/public/jobs/#{id}")
    image.write("#{Rails.root}/public/jobs/#{id}/#{file_name}")
  end

  def process_media
  end
end
