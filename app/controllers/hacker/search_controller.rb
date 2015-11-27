class Hacker::SearchController < HackerController

	def search_all
		User.reindex
		Project.reindex
		@users = User.search(params[:q], partial: true, limit: 5)
		@projects = Project.search(params[:q], partial: true, limit: 5)
	end

end
