namespace :hashtags do

  task :generate_all_images, :tag_name do |t, args|
    tag_name = args.tag_name
    HashtagAnalytics.save_all_tag_images tag_name
  end

  task :generate_top_performing_images, :tag_name do |t, args|
    tag_name = args.tag_name
    HashtagAnalytics.save_top_performing_images tag_name
  end
 
end