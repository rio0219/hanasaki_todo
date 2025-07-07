class GoalsController < ApplicationController
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

  private

  def goal_params
    params.require(:goal).permit(:title, tasks_attributes: [:title])
  end
end

