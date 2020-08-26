class TasksController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  before_action :set_task, only:[:show,:edit,:update,:destroy]
  before_action :set_tasklist, only:[:index,:show,:calendar,:custom,:new,:create,:edit,:update]
  before_action :set_now_datetime, only:[:index,:show,:new,:create,:edit,:update]
  before_action :week_day_index_string, only:[:create,:update]
  
  def index
  end
  
  def show
  end
  
  def calendar
  end
  
  def custom
    @task = current_user.tasks.build
  end
  
  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Task が正常に設定されました'
      if @task.status == 'custom'
        redirect_to '/tasks/custom'
      else
        redirect_to tasks_path
      end
    else
      flash.now[:danger] = 'Task が設定されませんでした'
      if @task.status == 'custom'
        redirect_to '/tasks/custom'
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      if @task.status == 'custom'
        redirect_to '/tasks/custom'
      else
        redirect_to tasks_path
      end
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    if @task.status == 'custom'
      @status = 'custom'
    else
      @status = 'normal'
    end
    @task.destroy
    flash[:success] = 'Taskは正常に削除されました'
    if @status == 'custom'
      redirect_to '/tasks/custom'
    else
      redirect_to tasks_path
    end
  end

  private
  
  def set_task
    @task = current_user.tasks.find(params[:id])
  end
  
  def set_tasklist
    @tasks = current_user.tasks.order('start_at').where("tasks.end_on >= ?", Time.zone.now).page(params[:page])
    @expired_tasks = current_user.tasks.order('start_on').order('start_at').where("tasks.start_on <= ?", Time.zone.now).page(params[:page])
    # 習慣タスクとの併合版 @tasks_with_customs の作成。
    @tasks_with_customs_first = current_user.tasks.order('start_at').where("tasks.start_at >=?",Time.parse("2000-1-1 15:00")).page(params[:page])
    @tasks_with_customs_second = current_user.tasks.order('start_at').where("tasks.start_at <=?",Time.parse("2000-1-1 15:00")).where("tasks.end_at <=?",Time.parse("2000-1-1 15:00")).page(params[:page])
  end
  
  def set_now_datetime
    @now = Time.zone.now
    @tomorrow = @now + 1.days
  end
  
  def task_params
    params.require(:task).permit(:title,:status,:content,:start_on,:start_at,:end_on,:end_at,:week_day_index)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
  def week_day_index_string
    if params[:task][:week_day_index] != nil
      params[:task][:week_day_index] = params[:task][:week_day_index].join("/")
      # week_day_indexに入れる曜日指定をstring型に変換する
    else
      flash.now[:danger] = 'Task が設定されませんでした'
      redirect_to '/tasks/custom'
    end
  end
end
