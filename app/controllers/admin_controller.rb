class AdminController < ApplicationController
  def index
  end

  def posts
    # .includes(:user, :comments): Phương thức includes cho phép eager loading dữ liệu liên quan đến bài đăng. 
    # Trong trường hợp này, eager loading thông tin người dùng (user) và bình luận (comments) cho từng bài đăng.
    @posts = Post.all.includes(:user, :comments)
  end

  def comments
  end

  def users
  end

  def show_post
    @post = Post.all.includes(:user, :comments).find(params[:id])
  end
end
