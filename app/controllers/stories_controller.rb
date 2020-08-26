class StoriesController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  before_action :set_story, only:[:show,:edit,:update,:destroy]
  before_action :set_storylist, only:[:index,:show,:new,:create,:edit,:update]
  
  def index
  end

  def show
  end

  def new
    @story = current_user.stories.build
  end

  def create
    @story = current_user.stories.build(story_params)
    if @story.save
      flash[:success] = 'storyの作成に成功しました'
      redirect_to stories_path
    else
      flash.now[:danger] = 'storyの作成に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @story.update(story_params)
      flash[:success] = 'storyは正常に更新されました'
      redirect_to stories_path
    else
      flash.now[:danger] = 'storyは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @story.destroy
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to stories_path
  end
  
  private
  
  def set_story
    @story = current_user.stories.find(params[:id])
  end
  
  def set_storylist
    @stories = current_user.stories.order(id: :desc).page(params[:page])
  end
  
  def story_params
    params.require(:story).permit(:title,:status,:content,:card_color,:favorite_score)
    # 必要なパラメータを把握し、送信データを精査する。
    # 本来ならparams.require(:task).permit(:title,:content,:start_date,:end_date)まで書く予定だったが、
    # doneやnot doneなどのボタンが上手く作動せず、require(:task)を抜くことで上手く作動したので、require(:task)を抜いた。
    # require(:task)は、Taskモデルのフォームから得られるデータに関するものであると明示するものであるため、
    # doneやnot doneなどのボタンが上手く作動しない。
  end
  
  def correct_user
    @story = current_user.stories.find_by(id: params[:id])
    unless @story
      redirect_to root_url
    end
  end
end