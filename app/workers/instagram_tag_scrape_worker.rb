class InstagramTagScrapeWorker < Struct.new(:tag_name, :min_tag_id, :max_tag_id)

  def perform
    Hashtag.scrape(tag_name, min_tag_id, max_tag_id)
  end

end
