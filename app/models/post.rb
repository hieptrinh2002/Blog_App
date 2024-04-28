class Post < ApplicationRecord
    validates :title, presence: true, length:{ minimum: 5 , maximum: 100 }
    validates :body, presence: true, length:{ minimum:10 }
    belongs_to :user
    has_many :comments, dependent: :destroy  #{ delete post => delete comment }

    has_rich_text :body
    has_one :content, class_name: "ActionText::Richtext", as: :record, dependent: :destroy

    
    # Dòng này thiết lập mối quan hệ has_many giữa model Post và model Notification.
    # Qua đó, mỗi đối tượng Post có thể có nhiều đối tượng Notification liên quan.
    # Dòng through: :user chỉ ra rằng mối quan hệ thông qua model User, tức là thông qua một mối quan hệ giữa Post và User, 
    #   thông qua User, các Notification liên quan sẽ được truy xuất.
    # dependent: :destroy chỉ ra rằng khi một đối tượng Post bị xóa, tất cả các đối tượng Notification 
    # liên quan đến nó cũng sẽ bị xóa.
    has_many :notifications, through: :user

    # Dòng này sử dụng phương thức has_noticed_notifications của gem Noticed để thiết lập mối quan hệ giữa 
    #   model Post và model Notifications.
    # Điều này cho phép model Post có khả năng tạo ra và nhận các thông báo (notifications) thông qua gem Noticed.
    
    has_noticed_notifications model_name:"Notification"
    # Chỉ có một mối quan hệ được liệt kê là "user". 
    # Điều này có nghĩa là Ransack có thể tìm kiếm các bản ghi trong mô hình Post dựa trên 
    # các giá trị trong mối quan hệ "user".

end
