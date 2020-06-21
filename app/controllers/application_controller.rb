class ApplicationController < ActionController::Base
  skip_before_action :verfiy_authenticity_token
end
