class GoalsController < ApplicationController
  def record
    @goal = Goal.includes(:tasks).find(params[:id])
    @today = Date.current
  
    @records = @goal.tasks.map do |task|
      TaskRecord.find_or_initialize_by(task: task, date: @today)
    end
  end
  
  def record_submit
    goal = Goal.find(params[:id])
    today = Date.current
  
    records_params = params[:records] || []
    count = records_params.count { |r| r[:done] == "1" }
  
    records_params.each do |record_param|
      task_id = record_param[:task_id]
      done = record_param[:done] == "1"
  
      task = Task.find(task_id)
      task_record = TaskRecord.find_or_initialize_by(task: task, date: today)
      task_record.done = done
      task_record.save!
    end
  
    # DailyRecord を保存
    daily_record = DailyRecord.find_or_initialize_by(goal: goal, date: today)
    daily_record.count = count
    daily_record.save!
  
    redirect_to goals_path, notice: "記録を保存しました（達成数: #{count}）"
  end 
  
  def records_data
    goal = Goal.find(params[:id])
  
    # 日付範囲：最初の記録日から今日まで（なければ今日のみ）
    start_date = goal.daily_records.minimum(:date) || Date.current
    end_date = Date.current
  
    # 日付ごとに初期化（全部0）
    date_range = (start_date..end_date).to_a
    records_hash = date_range.index_with { 0 }
  
    # 実データで上書き
    goal.daily_records.pluck(:date, :count).each do |date, count|
      records_hash[date] = count
    end
  
    # 日付と達成数の配列で返す
    render json: {
      dates: records_hash.keys,
      counts: records_hash.values
    }
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
end

