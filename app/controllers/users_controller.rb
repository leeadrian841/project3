class UsersController < ApplicationController

def home
  @tasks = Task.all
  @creatorTasks = Task.with_role(:creator, current_user)
  @appliedTasks = Task.with_role(:applicant, current_user)
  @workingTasks = Task.with_role(:worker)
  @otherTasks = @tasks - @creatorTasks
  @otherTasks = @otherTasks - @appliedTasks
  @allTasks = @otherTasks - @workingTasks
end

def show
  @user = User.find(params[:id])
  @completedTasks = Task.where("completed_worker= ? AND completed_creator= ?", true, true)
  @userTasks = @completedTasks.with_role(:creator, @user)
  @otherTasks = @completedTasks - @userTasks
end

def create
end

def contact
end
end
