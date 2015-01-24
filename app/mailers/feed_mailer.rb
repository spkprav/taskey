class FeedMailer < ActionMailer::Base
  default from: "webpunditzz@gmail.com"

  def assigned(to,subject,task_id,group_id,user)
    @to = to
    @subject = subject
    @task_id = task_id
    @group_id = group_id
    @user = user
    mail :subject => "[Taskey] "+subject, :to => to
  end

  def comment(to,subject,comment,task_id,group_id,user,task_user)
    @to = to
    @subject = subject
    @comment = comment
    @task_id = task_id
    @group_id = group_id
    @user = user
    @task_user = task_user
    mail :subject => "[Taskey] "+user.name+ " replied to: "+ subject, :to => to
  end
end
