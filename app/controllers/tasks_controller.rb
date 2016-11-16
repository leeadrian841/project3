class TasksController < ApplicationController
  around_filter :catch_not_found
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
    @workingTasks = Task.with_role(:worker)
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
    redirect_to '/tasks', :flash => { :alert => "Sorry, but you can't edit that task as you are not the creator." } unless (User.with_role(:creator, @task).include? current_user)
  end

  def accept
    @task = Task.find(params[:id])
    @worker = User.find(params[:worker])
    @worker.add_role :worker, @task
    @worker.remove_role :applicant, @task
    redirect_to @task, :flash => { :notice => "This applicant is accepted." }
  end

  def reject
    @task = Task.find(params[:id])
    @worker = User.find(params[:worker])
    @worker.remove_role :applicant, @task
    redirect_to @task, :flash => { :notice => "1 applicant is just rejected." }
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
      redirect_to @task, :flash => { :notice => "Task is just updated." }
    else
      flash[:alert] = "Sorry, but there was an error in updating. Please try again."
      render 'edit'
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "Task successfully deleted"
    redirect_to tasks_path
  end

  def apply
    @task = Task.find(params[:id])
    @user = current_user
    if (@user.has_role? :creator, @task || User.with_role(:worker, @task) != []) || (@user.has_role? :applicant, @task)
        redirect_to '/tasks', :flash => { :notice => "Not able to apply as you are a creator/applicant or there is already someone working on this task." }
        # flash[:notice] = "Not able to apply because I am creator/user/there is a worker"
    # check if user is creator
    # check if there is a worker for this task
    # check if user has already applied
    else
      applicant_role
      redirect_to "/tasks", :flash => { :notice => "You have successfully applied for this task. Wait for your good news!" }
    end
  end

  def drop_role
    @task = Task.find(params[:id])
    delete_role
    redirect_to "/tasks", :flash => { :notice => "You just dropped 1 application." }
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

  def catch_not_found
    yield
    rescue ActiveRecord::RecordNotFound
    redirect_to root_url, :flash => { :alert => "Record not found." }
  end

  def task_params
      params.require(:task).permit(:name, :duration, :info, :category, :location, :price)
  end

end
