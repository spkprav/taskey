class FeedMailer < ActionMailer::Base
  default from: "webpunditzz@gmail.com"

  def assigned(to,subject,message,task_id,group_id,user,url)
    @to = to
    @subject = subject
    @message = message
    @task_id = task_id
    @group_id = group_id
    @user = user
    @url = url
    mail :subject => "[Taskey] "+subject, :to => to
  end
  
  def comment(to,name,subject,comment,task_id,group_id,user,task_user,url)
    @to = to
    @subject = subject
    @comment = comment
    @task_id = task_id
    @group_id = group_id
    @user = user
    @task_user = task_user
    @url = url
    mail :subject => "[Taskey] "+user.name+ " replied to: "+ subject, :to => to
  end
end
