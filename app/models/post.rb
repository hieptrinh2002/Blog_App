class Post < ApplicationRecord

    extend FriendlyId
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

    friendly_id :title, use: %i[slugged history finders]  #{ p %i[slugged] -> [:plugged] }. 
    # Có finders sẽ không cần .friendly nữa  
    #post = Post.friendly.find(params[:post_id]) -> @post = Post.find(params[:post_id])


    # Bất cư khi nào titte change -> true , nó sẽ genarate friendlyId dựa trên title hoặc sẽ grenarate friendlyId khi
    # slug blank
    # title_changed sẽ hoạt động kho thêm mới một new post
    # slug.blank sẽ hoạt động khi okie, tôi cần generate ra một friendlyId ti set equal to title
    def should_generate_new_friendly_id?
        title_changed? || slug.blank?
    end
end
