class Hacker::ThreadTablesController < HackerController
  def index
  	@thread_tables = ThreadTable.all.order(created_at: 'desc')
  end

  def new
  	@thread_table = ThreadTable.new
  end

  def create
  	@thread_table = ThreadTable.new(thread_table_params)
  	if @thread_table.save
  		redirect_to hacker_thread_table_responses_path(@thread_table.id)
  	else
  		render :new
  	end
  end

  private

  def thread_table_params
  	params.require(:thread_table).permit(:title, :content, :image, :image_cache, :remove_image)
  end
end
