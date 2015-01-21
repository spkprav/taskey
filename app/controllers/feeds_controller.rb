class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!
  
  respond_to :html

  def index
    @feeds = Feed.all
    respond_with(@feeds)
  end

  def show
    respond_with(@feed)
  end

  def new
    @feed = Feed.new
    respond_with(@feed)
  end

  def edit
  end

  def create
    @feed = Feed.new(feed_params)

    respond_to do |format|
      if @feed.save
        format.html { redirect_to root_url, notice: 'Feed was successfully created.' }
      else
        format.html { redirect_to root_url }
      end
    end
  end

  def update
    @feed.update(feed_params)
    respond_with(@feed)
  end

  def destroy
    @feed.destroy
    respond_with(@feed)
  end

  private
    def set_feed
      @feed = Feed.find(params[:id])
    end

    def feed_params
      params.require(:feed).permit(:title, :description, :file, :user_id,:task_id)
    end
end
