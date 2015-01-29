#class FilmsController < ApplicationController
class FilmsController < ActionController::API
  #protect_from_forgery with: :null_session

  def finish_task
    Rails.logger.info('------------------------------------')
    Rails.logger.info(params.inspect)
    Rails.logger.info('------------------------------------')
    #result = Task.update_task(params[:data])
    #render :json => {success:result}
  end

  def get_task   
    task = Task.get_site_task(params[:site])
    success = false 
    success = true if task.present?
    render :json =>{success:success,url:task.try(:task_url),parent_url:task.try(:parent_url)}
  end


  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_film
  #     @film = Film.find(params[:id])
  #   end

  #   def task_params
  #     params.require(:task).permit(:title, :site, :task_url,:child_url,:from,:url,:basic_info)
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def film_params
  #     params.require(:film).permit(:title, :task_url, :status)
  #   end
end
