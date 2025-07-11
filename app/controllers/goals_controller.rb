class GoalsController < ApplicationController
  def record
    puts "★★ recordアクションが呼ばれました"
    puts "★★ params[:id] = #{params[:id].inspect}"

    @goal = Goal.includes(:tasks).find(params[:id])
    puts "★★ @goal = #{@goal.inspect}"

    @today = Date.current
    @records = @goal.tasks.map do |task|
      TaskRecord.find_or_initialize_by(task: task, date: @today)
    end
  end
  def new
    @goal = Goal.new
    5.times { @goal.tasks.build }
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      redirect_to root_path, notice: "目標とタスクを登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @goals = Goal.includes(:tasks).all
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goals_path, notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_path, notice: "目標を削除しました"
  end

  private

  def goal_params
    params.require(:goal).permit(:title, tasks_attributes: [:id, :title, :_destroy])
  end
  # 記録ページを表示
  
  

# 記録を保存
  def record_submit
    params[:records]&.each do |record_params|
      record = TaskRecord.find_or_initialize_by(task_id: record_params[:task_id], date: Date.current)
      record.done = record_params[:done] == "1"
      record.save!
    end

    redirect_to goals_path, notice: "記録を保存しました"
  end
end

