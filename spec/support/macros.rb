def login
  session[:user_id] = Fabricate(:user).id
end

def current_user
  User.find(session[:user_id])
end