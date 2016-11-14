class UsersController < ApplicationController

def home
@allTasks = Task.all
end

def create

end
end
