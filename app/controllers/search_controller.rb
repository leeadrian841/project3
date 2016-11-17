class SearchController < ApplicationController
  def index
    @tasks = Task.all
    @creatorTasks = Task.with_role(:creator, current_user)
    @appliedTasks = Task.with_role(:applicant, current_user)
    @workingTasks = Task.with_role(:worker)
    @completedTasks = Task.where("completed_worker= ? AND completed_creator= ?", true, true)
    @otherTasks = @tasks - @creatorTasks
    @otherTasks = @otherTasks - @appliedTasks
    @otherTasks = @otherTasks - @workingTasks
    @otherTasks = @otherTasks - @completedTasks
  end
end
