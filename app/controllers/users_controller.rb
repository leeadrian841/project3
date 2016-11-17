class UsersController < ApplicationController

def home
  @tasks = Task.all
  # @creatorTasks = Task.with_role(:creator, current_user)
  @appliedTasks = Task.with_role(:applicant, current_user)
  @workingTasks = Task.with_role(:worker)
  @completedTasks = Task.where("completed_worker= ? AND completed_creator= ?", true, true)
  # @otherTasks = @tasks - @creatorTasks
  @otherTasks = @tasks - @appliedTasks
  @otherTasks = @otherTasks - @workingTasks
  @allTasks = @otherTasks - @completedTasks
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
