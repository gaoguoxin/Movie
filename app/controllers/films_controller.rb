class FilmsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
      
  end

  def show
  end


  # GET /films/new
  def new
    @task = Task.new
  end

  # GET /films/1/edit
  def edit
  end

  # POST /films
  # POST /films.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: '创建成功' }
      end
    end
  end

  # PATCH/PUT /films/1
  # PATCH/PUT /films/1.json
  def update
    respond_to do |format|
      if @film.update(film_params)
        format.html { redirect_to @film, notice: 'Film was successfully updated.' }
        format.json { render :show, status: :ok, location: @film }
      else
        format.html { render :edit }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  #ajax server
  def finish_task
    result = Task.update_task(params[:data])
    render :json => {success:result}
  end

  def get_task   
    task = Task.get_site_task(params[:site])
    render :json =>{success:true,url:task.task_url,parent_url:task.parent_url}
  end

  # DELETE /films/1
  # DELETE /films/1.json
  def destroy
    @film.destroy
    respond_to do |format|
      format.html { redirect_to films_url, notice: 'Film was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_film
      @film = Film.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :site, :task_url,:child_url,:from,:url,:basic_info)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def film_params
      params.require(:film).permit(:title, :task_url, :status)
    end
end
