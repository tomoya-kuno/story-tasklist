class TasksController < ApplicationController
  def index
    @tasks = Task.order('start_date').page(params[:page])
    @status = ['not done','done']
  end

  def show
    @task = Task.find(params[:id])
    @tasks = Task.order('start_date').page(params[:page])
  end

  def new
    @task = Task.new
    @tasks = Task.order('start_date').page(params[:page])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'Task が正常に設定されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Task が設定されませんでした'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
    @tasks = Task.order('start_date').page(params[:page])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to @task
  end

  private

  def task_params
    params.require(:task).permit(:title,:content,:status,:start_date,:end_date)
    #必要なパラメータを把握し、送信データを精査する
  end
end
