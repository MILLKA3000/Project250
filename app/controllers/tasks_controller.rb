class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction, :task_users_column, :sort_direction_for_users
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
   @task = current_user.tasks.order("#{sort_column} #{sort_direction}").paginate(:per_page => 20, :page => params[:page])
  end

  def show
   if @task = Task.find_by_id(params[:id])
     @old_user = @task.users
   else
     redirect_to tasks_path
   end
  end

  def show_users_task
    if @task = current_user.tasks.find_by_id(params[:id])
      @old_user = @task.users.order("#{task_users_column} #{sort_direction}").paginate(:per_page => 20, :page => params[:page])
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
      flash[:alert] = "Sorry. The task there is"
    else
      if User.find_by_id(params[:id])
        flash[:success] = "User add" if Journal.new(user_id: params[:id], task_id: params[:id_task]).save
      else
        flash[:alert] = "No search user"
      end
    end
    redirect_to show_users_task_path(params[:id_task])
  end

  def view_all_tasks
    @task = Task.order("#{sort_column} #{sort_direction}").paginate(:per_page => 20, :page => params[:page])
    @task.map do |el|
      users = Journal.where(task_id: el[:id])
       users.map do |em|
          em[:name] = User.find(em.user_id)
       end
      if (sort_direction_for_users=="asc")
        el[:users] = users.sort_by{|k, v| k}
      else
        el[:users] = users.sort_by{|k, v| k}.reverse
      end
    end

  end

  private

  def sort_column
      Task.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def task_users_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "fname"
  end

  def sort_direction
       %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_direction_for_users
    %w[asc desc].include?(params[:direction_users]) ? params[:direction_users] : "asc"
  end
end
