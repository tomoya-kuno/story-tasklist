class TasksController < ApplicationController
  before_action :require_user_logged_in ,except:[:index]
  before_action :correct_user, only: [:destroy]
  def index
    if logged_in?
      @tasks = current_user.tasks.order('start_date').page(params[:page])
      @now = Time.zone.now
      # 時間を表示する変数の追加
    end
  end

  def show
    @task = current_user.tasks.find(params[:id])
    @tasks = current_user.tasks.order('start_date').page(params[:page])
  end
  
  def calendar
    # カレンダー表示
    @tasks = current_user.tasks.order('start_date').page(params[:page])
  end
  
  def custom
    @task = current_user.tasks.build(status: 'custom')
    @tasks = current_user.tasks.order('start_date').page(params[:page])
  end
  
  def new
    @task = current_user.tasks.build
    @tasks = current_user.tasks.order('start_date').page(params[:page])
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Task が正常に設定されました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'Task が設定されませんでした'
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
    @tasks = current_user.tasks.order('start_date').page(params[:page])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to root_url
  end

  private

  def task_params
    params.permit(:title,:status,:content,:start_date,:end_date)
    #必要なパラメータを把握し、送信データを精査する
    # 本来ならparams.require(:task).permit(:title,:content,:start_date,:end_date)まで書く予定だったが、
    # doneやnot doneなどのボタンが上手く作動せず、require(:task)を抜くことで上手く作動したので、require(:task)を抜いた。
    # require(:task)は、Taskモデルのフォームから得られるデータに関するものであると明示するものであるため、
    # doneやnot doneなどのボタンが上手く作動しない。
  end
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
