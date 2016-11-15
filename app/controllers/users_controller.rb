class UsersController < ApplicationController

def home
@allTasks = Task.all
end

def show
  @user = User.find(params[:id])
end

def create

end
end
