class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks

  def index
    @tasks =Task.all
    @creator = current_user.roles.where(name: "creator")
    @creatorSearch = Array.new
    @creator.each { |role| @creatorSearch.push(Task.find(role.resource_id)) }
    @worker = current_user.roles.where(name: "worker")
    @workerSearch = Array.new
    @worker.each { |role| @workerSearch.push(Task.find(role.resource_id)) }
    @Othertasks = @tasks - @creatorSearch
    @Othertasks = @Othertasks - @workerSearch
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1
  # GET /tasks/1.json (for ajax if needed)
  def show
    @task = Task.find(params[:id])
    @creator = current_user.roles.where(name: "creator")
    @creatorSearch = Array.new
    @creator.each { |role| @creatorSearch.push(Task.find(role.resource_id)) }
    @worker = current_user.roles.where(name: "worker")
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:notice]= "Task was successfully listed."
      assign_role
      redirect_to @task
    else
      flash[:error]= "There was an error in creating the task."
      render :new
    end
  end

  # PATCH/PUT /tasks/1

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      redirect_to @task
    else
      render 'edit'
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
  end

  def apply
    @task = Task.find(params[:id])
    worker_role
    redirect_to "/tasks"
  end


  def assign_role
    current_user.add_role :creator, @task
  end

  def worker_role
    current_user.add_role :worker, @task
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :duration, :info, :category, :location, :price)
    end
end
