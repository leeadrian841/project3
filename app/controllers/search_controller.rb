class SearchController < ApplicationController
  def index
    @tasks = Task.all
    @creatorTasks = Task.with_role(:creator, current_user)
    @appliedTasks = Task.with_role(:applicant, current_user)
    @workingTasks = Task.with_role(:worker)
    @otherTasks = @tasks - @creatorTasks
    @otherTasks = @otherTasks - @appliedTasks
    @otherTasks = @otherTasks - @workingTasks
  end
end
