class Task < ActiveRecord::Base
  cattr_accessor :current_user
  has_many :feeds
  belongs_to :user
  belongs_to :group
  after_create :create_feed
  after_update :update_feed

  def create_feed
    tmp = {
      task_id: self.id,
      description: self.current_user.email + " Created the task",
      user_id: self.current_user.id
    }
    Feed.create(tmp)
  end

  def update_feed
    if description_changed?
      tmpd = {
        task_id: self.id,
        description: self.current_user.email + " updated the description",
        user_id: self.current_user.id
      }
      Feed.create(tmpd)
    end

    if title_changed?
      tmpt = {
        task_id: self.id,
        description: self.current_user.email + " updated the title",
        user_id: self.current_user.id
      }
      Feed.create(tmpt)
    end

    if user_id_changed?
      if self.user_id != nil
        tmpui = {
          task_id: self.id,
          description: self.current_user.email + " assigned task to " + User.find(self.user_id).email,
          user_id: self.current_user.id
        }
        Feed.create(tmpui)
      else
        tmpui = {
          task_id: self.id,
          description: self.current_user.email + " unassigned task",
          user_id: self.current_user.id
        }
        Feed.create(tmpui)
      end
    end

    if completed_changed?
      if self.completed
        tmpc = {
          task_id: self.id,
          description: self.current_user.email + " marked the task as complete",
          user_id: self.current_user.id
        }
        Feed.create(tmpc)
      else
        tmpc = {
          task_id: self.id,
          description: self.current_user.email + " marked the task as incomplete",
          user_id: self.current_user.id
        }
        Feed.create(tmpc)
      end
    end
  end
end
