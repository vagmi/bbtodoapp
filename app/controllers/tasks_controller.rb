class TasksController < ApplicationController
  respond_to :json
  def index
    @tasks = Task.all
    respond_with(@tasks)
  end
  def create
    @task = Task.create(params[:task])
    respond_with(@task)
  end
  def show
    @task = Task.find(params[:id])
    respond_with(@task)
  end
  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])
    respond_with(@task)
  end
end
