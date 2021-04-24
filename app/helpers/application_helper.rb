module ApplicationHelper
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in? 
    !!current_user
  end

  def review_rating_options
    (1..5).to_a.reverse.map do |n|
      ["#{n} #{n > 1 ? 'stars' : 'star'}", n]
    end
  end
end
