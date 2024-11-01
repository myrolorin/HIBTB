class BlogPostsController < ApplicationController
    before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
    before_action :check_admin, only: [:new, :create, :edit, :update, :destroy]

    def index
        @blog_posts = BlogPost.all.order(created_at: :desc)
    end

    def show
        @blog_post = BlogPost.find(params[:id])
        @can_edit = @current_user && (@current_user.admin? || current_user == @blog_post.user)
    end

    def new
        @blog_post = BlogPost.new
    end

    def create
        @blog_post = current_user.blog_posts.build(blog_post_params)
        if @blog_post.save
            redirect_to @blog_post, notice: 'Blog post was successfully created.'
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @blog_post.update(blog_post_params)
            redirect_to @blog_post, notice: 'Blog post was successfully updated.'
        else
            render :edit
        end
    end
    
    def destroy
        if @blog_post.user == current_user || current_user&.admin?
          if @blog_post.destroy
            redirect_to root_path, notice: 'Blog post was successfully deleted.'
          else
            redirect_to @blog_post, alert: 'Failed to delete the blog post.'
          end
        else
          redirect_to root_path, alert: 'You are not authorized to delete this blog post.'
        end
      end

    private

    def set_blog_post
        @blog_post = BlogPost.find(params[:id])
    end
    
    def check_admin
        redirect_to root_path, alert: 'Access denied.' unless current_user&.admin?
    end
    
    def blog_post_params
        params.require(:blog_post).permit(:title, :body)
    end
    
end