class UsersController < ApplicationController
  def show
    @time = Time.now
    @hello = 'Hello!'
  end
end
