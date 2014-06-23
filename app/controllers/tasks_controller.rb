class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction
  def new
    @task = current_user.task.new
  end

  def create
    @task = current_user.task.new(params[:task])
    if @task.save
      redirect_to tasks_path, :notice => "Complited"
    else
      render "new"
    end
  end

  def edit
    if @task = current_user.task.find(params[:id])
      render "new"
    else
      redirect_to tasks_path
    end

  end

  def update
    @task = current_user.task.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to tasks_path, :notice => "Successfully updated task."
    else
      render "new"
    end
  end


  def destroy
    task = current_user.task.find(params[:id])
    if @d = task.destroy
      flash[:success] = "Task '#{task.name}' deleted"
    else
      redirect_to @d
    end
    redirect_to tasks_path
  end

  def index
    @task = current_user.task.order(sort_column + " " + sort_direction)
  end

  def show
   if @task = current_user.task.find(params[:id])
   else
     redirect_to tasks_path
   end
  end

  private

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
