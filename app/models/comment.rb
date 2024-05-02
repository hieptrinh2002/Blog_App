class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  
  has_rich_text :body

  after_create_commit :notify_recepient
  before_destroy :cleanup_notifications

  has_noticed_notifications model_name:"Notification"

  # has_noticed_notifications model_name:"Notifications":
    # Dòng này sử dụng phương thức has_noticed_notifications của gem Noticed để thiết lập mối quan hệ 
    #    giữa model Comment và model Notifications.
    # Điều này cho phép model Comment có khả năng tạo ra và nhận các thông báo (notifications) thông qua gem Noticed.
    # Bằng cách thiết lập model_name là "Notifications", model Notifications sẽ được liên kết với model Comment thông qua mối quan hệ thông báo.


    private
    def notify_recepient
      CommentNotification.with(comment: self, post: post).deliver_later(post.user)
    end


    def cleanup_notifications
      notifications_as_comment.destroy_all # check và hủy tất cả các thông báo liên quan đến comment
    end
end
