module CountHelper
  def posts_count(n)
    t(:posts_count, :count => n, :n => number_with_delimiter(n))
  end

  def posts_count_found(n)
    t(:posts_count_found, :count => n, :n => number_with_delimiter(n))
  end

  def voices_count(n)
    t(:voices_count, :count => n, :n => number_with_delimiter(n)) 
  end
end
