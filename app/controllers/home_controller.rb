class HomeController < ApplicationController

  def index
		if current_login.nil?
   		redirect_to search_path
		elsif current_login.is_admin?
			redirect_to actor_types_path
		else
			redirect_to actors_path
		end
  end

end
