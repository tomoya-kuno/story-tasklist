class FormsController < ApplicationController
  def create
    @setting = ActiveSupport::OrderedOptions.new
    @setting.date = params[:date]
    @setting.url = params[:url]
    if Rails.application.routes.recognize_path(request.referrer) == {:controller=>"tasks", :action=>"index"}
      redirect_to tasks_path(date: @setting.date)
    elsif Rails.application.routes.recognize_path(request.referrer) == {:controller=>"tasks", :action=>"show"}
      redirect_to show_task_path(date: @setting.date)
    elsif Rails.application.routes.recognize_path(request.referrer) == {:controller=>"tasks", :action=>"edit"}
      redirect_to edit_task_path(date: @setting.date)
    else
      redirect_to new_task_path(date: @setting.date)
    end
  end
end
