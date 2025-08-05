class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :goals, dependent: :destroy
  has_many :user_flowers
  has_many :flowers, through: :user_flowers
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def total_achievements
      goals.joins(:task_records)
      .where(task_records: { status: true }) # 達成済みの記録
      .count
  end
end
