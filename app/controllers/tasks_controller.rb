class TasksController < ApplicationController
  
  def index
    @creatorTasks = Task.with_role(:creator, current_user)
    @appliedTasks = Task.with_role(:applicant, current_user)
    @workerTasks = Task.with_role(:worker, current_user)
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1
  # GET /tasks/1.json (for ajax if needed)
  def show
    @task = Task.find(params[:id])
    @creator = Task.with_role(:creator, current_user)
    @applied = Task.with_role(:applicant, current_user)
    @applicants = User.with_role(:applicant, @task)
    @worker = User.with_role(:worker, @task)
    if @worker.to_a != []
      @workerName = @worker.to_a.first.username
    end
    @userName = User.with_role(:creator, @task).to_a.first.username
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  def accept
    @task = Task.find(params[:id])
    @worker = User.find(params[:worker])
    @worker.add_role :worker, @task
  end

  # POST /tasks

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:notice]= "Task was successfully listed."
      creator_role
      redirect_to @task
    else
      redirect_to new_task_url
      flash[:notice]= "There was an error in creating the task."
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
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "Task deleted"
    redirect_to tasks_path
  end

  def apply
    @task = Task.find(params[:id])
    applicant_role
    redirect_to "/tasks"
  end

  def drop_role
    @task = Task.find(params[:id])
    delete_role
    redirect_to "/tasks"
  end

  def creator_role
    current_user.add_role :creator, @task
  end

  def applicant_role
    current_user.add_role :applicant, @task
  end

  def delete_role
    current_user.remove_role :applicant, @task
  end

  private

  
  def task_params
      params.require(:task).permit(:name, :duration, :info, :category, :location, :price)
  end

end
