class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      current_user.tasks << @task
      redirect_to tasks_path, :notice => "Complited"
    else
      render "new"
    end
  end

  def edit
    if @task = current_user.tasks.find_by_id(params[:id])
      @old_user = @task.users
      render "new"
    else
      redirect_to tasks_path
    end

  end

  def update
    @task = current_user.tasks.find_by_id(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to tasks_path, :notice => "Successfully updated task."
    else
      render "new"
    end
  end


  def destroy
    task = current_user.tasks.find_by_id(params[:id])
    if @d = task.destroy
      flash[:success] = "Task '#{task.name}' deleted"
    else
      redirect_to @d
    end
    redirect_to tasks_path
  end

  def index
   @task = current_user.tasks.order("#{sort_column} #{sort_direction}")
  end

  def show
   if @task = current_user.tasks.find_by_id(params[:id])
     @old_user = @task.users
   else
     redirect_to tasks_path
   end
  end

  def show_users_task
    if @task = current_user.tasks.find_by_id(params[:id])
      @old_user = @task.users
    else
      redirect_to tasks_path
    end
  end

  def delete_users
    j = Journal.where(user_id: params[:id_user]).where(task_id: params[:id_task]).first
    flash[:success] = "User destroy" if j.destroy
    redirect_to show_users_task_path(params[:id_task])
  end

  def create_users_for_task
    j = Journal.where(user_id: params[:id]).where(task_id: params[:id_task]).first
    if j
      flash[:success] = "Sorry. The task there is"
    else
      Journal.new(user_id: params[:id], task_id: params[:id_task]).save
    end
    redirect_to show_users_task_path(params[:id_task])
  end

  private

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
