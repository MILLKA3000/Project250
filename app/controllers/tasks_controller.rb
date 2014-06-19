class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params[:task])
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
    @task = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end



end
