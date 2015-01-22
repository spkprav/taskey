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
end
