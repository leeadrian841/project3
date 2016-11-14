class SearchController < ApplicationController
  def index
    @tasks = Task.all
    @creatorTasks = Task.with_role(:creator, current_user)
    @appliedTasks = Task.with_role(:applicant, current_user)
    @otherTasks = @tasks - @creatorTasks
    @otherTasks = @otherTasks - @appliedTasks
  end
end
