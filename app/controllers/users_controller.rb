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
end

def create
end

def contact
end
end
