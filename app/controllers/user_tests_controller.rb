class UserTestsController < ApplicationController
  def index
    @user_tests = UserTest.where(user_id: current_user)
    @tests = []
    @user_tests.each do |user_test|
      @tests.include?(user_test.test) ? @tests : @tests << user_test.test
    end
  end

  def show
    @user_test = UserTest.find(params[:id])
    @test = Test.find(@user_test.test_id)
    global_answer = JSON.parse @user_test.answer
    @answers = global_answer["answers"]
    case @test.name.downcase
    when "lecture dans les yeux"
      @raw_score = @user_test.lecture_yeux_good_answers
    end
  end

  def new
    @test = Test.find_by_name(params[:test_name])
    @user_test = UserTest.new
  end

  def create
    @user_test = UserTest.new(user_test_params)
    @user_test.user = current_user
    @user_test.completed = true
    @test = Test.find_by_name(params[:test_name])
    @user_test.test = @test
    case @test.name.downcase
    when "liste de mots"
      @user_test.answer = @user_test.words_list_validation
      @user_test.score = @user_test.words_list_score
    when "test de la nasa"
      @user_test.answer = @user_test.nasa_validation
      @user_test.score = @user_test.nasa_score
    when "lecture dans les yeux"
      @user_test.answer = @user_test.lecture_yeux_validation
      @user_test.score = @user_test.lecture_yeux_score
    end
    if @user_test.save
      redirect_to test_user_test_path(@test.name, @user_test)
    else
      render :new
    end
  end

  private

  def user_test_params
    params.require(:user_test).permit(:complete, :answer, :score, :user_id, :test_name)
  end
end
