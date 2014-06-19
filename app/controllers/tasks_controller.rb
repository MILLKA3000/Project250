class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params[:task])
    @task.u_id(session[:user_id])
    if @task.save
      redirect_to tasks_path, :notice => "Complited"
    else
      render "new"
    end
  end

  def edit
    @task = Task.find(params[:id])
    render "new"
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to tasks_path, :notice => "Successfully updated task."
    else
      render "new"
    end
  end


  def destroy
    task = Task.find(params[:id])
    if @d = task.destroy
      flash[:success] = "Task '#{task.name}' deleted"
    else
      redirect_to @d
    end
    redirect_to tasks_path
  end

  def index
    @task = Task.where(user_id: session[:user_id])
  end

  def show
    @task = Task.find(params[:id])
  end



end
