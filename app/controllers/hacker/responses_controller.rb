class Hacker::ResponsesController < HackerController

  def index
  	@responses = Response.all.where(thread_table_id: params[:thread_table_id])
  	@thread_table = ThreadTable.find(params[:thread_table_id])
  	@new_respone = Response.new
  end

  def create
  	@response = Response.new(params.require(:response).permit(:content))
  	@response.thread_table_id = params[:thread_table_id]
  	@response.user_id = current_user.id
  	@response.save
  	redirect_to hacker_thread_table_responses_path(params[:thread_table_id])
  end

end
