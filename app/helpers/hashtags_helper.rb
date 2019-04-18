module HashtagsHelper
  def add_hashtag_links(s)
    s.gsub(Hashtag::REGEXP) { |name| link_to name, hashtag_url(name) }.html_safe
  end
end
