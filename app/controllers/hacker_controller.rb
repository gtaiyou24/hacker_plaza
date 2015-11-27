class HackerController < ApplicationController
	layout 'hacker'
	before_action :authenticate_user!
end
