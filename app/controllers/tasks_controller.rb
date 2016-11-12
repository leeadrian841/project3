class TasksController < ApplicationController
  def index
    @creator = current_user.roles.where(name: "creator")
    @creatorSearch = Array.new
    @creator.each { |role| @creatorSearch.push(Task.find(role.resource_id)) }
    @worker = current_user.roles.where(name: "worker")
    @workerSearch = Array.new
    @worker.each { |role| @workerSearch.push(Task.find(role.resource_id)) }
  end
  def new
  end
  def show
    @task = Task.find(params[:id])
  end
  def create
    @task = Task.new(task_params)

    @task.save
    p @task

    assign_role
    redirect_to @task
  end



  def assign_role
    current_user.add_role :creator, @task
  end

  private
  def task_params
    params.require(:task).permit(:name, :duration, :info, :category, :location, :price)
  end

end
