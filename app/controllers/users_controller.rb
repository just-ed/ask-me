class UsersController < ApplicationController
  def index
    @users = [
        User.new(
            id: 1,
            name: 'Vadim',
            username: 'installero',
            avatar_url: 'https://secure.gravatar.com/avatar/71269686e0f757ddb4f73614f43ae445?s=100'
        ),
        User.new(id: 2, name: 'Misha', username: 'aristofun'),
        User.new(id: 3, name: 'Misha3', username: 'aristofun3'),
        User.new(id: 4, name: 'Misha4', username: 'aristofun4'),
        User.new(id: 5, name: 'Misha5', username: 'aristofun5'),
        User.new(id: 6, name: 'Misha6', username: 'aristofun6'),
        User.new(id: 7, name: 'Misha7', username: 'aristofun7'),
        User.new(id: 8, name: 'Misha8', username: 'aristofun8'),
        User.new(id: 9, name: 'Misha9', username: 'aristofun9')
    ]
  end

  def new
  end

  def edit
  end

  def show
    def show
      @user = User.new(
          name: 'Vadim',
          username: 'installero',
      )

      @questions = [
          Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
          Question.new(
              text: 'В чем смысл жизни?', created_at: Date.parse('27.03.2016')
          )
      ]

      @new_question = Question.new
    end
  end
end
