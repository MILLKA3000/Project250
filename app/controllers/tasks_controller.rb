class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction
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
    if @task = Task.where(id: params[:id]).where(user_id: session[:user_id]).first
      render "new"
    else
      redirect_to tasks_path
    end

  end

  def update
    @task = Task.where(id: params[:id]).where(user_id: session[:user_id]).first
    if @task.update_attributes(params[:task])
      redirect_to tasks_path, :notice => "Successfully updated task."
    else
      render "new"
    end
  end


  def destroy
    task = Task.where(id: params[:id]).where(user_id: session[:user_id]).first
    if @d = task.destroy
      flash[:success] = "Task '#{task.name}' deleted"
    else
      redirect_to @d
    end
    redirect_to tasks_path
  end

  def index
    @task = Task.where(user_id: session[:user_id]).order(sort_column + " " + sort_direction)
  end

  def show
   if @task = Task.where(id: params[:id]).where(user_id: session[:user_id]).first
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
