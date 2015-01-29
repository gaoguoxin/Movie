class TasksController < ApplicationController
  protect_from_forgery with: :null_session
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: '创建成功' }
      end
    end
  end

  private
    def task_params
      params.require(:task).permit(:title, :site, :task_url)
    end
end