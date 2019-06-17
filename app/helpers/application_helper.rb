module ApplicationHelper
  def simple_time(time)
   time.strftime("%Y年%m月%d日")
  end


  def facebook_url
   case Rails.env
   when "development"
     "https://www.facebook.com/dialog/oauth?client_id=595410730864234&redirect_uri=https%3A%2F%2Flocalhost:3000%2Fusers%2Fauth%2Ffacebook%2Fcallback&scope=email"
   when "production"
     "https://www.facebook.com/dialog/oauth?client_id=595410730864234&redirect_uri=https%3A%2F%2Ftabeshop.serveo.net%2Fusers%2Fauth%2Ffacebook%2Fcallback&scope=email"
   end
 end

end
