class UserTestsController < ApplicationController

  def show
    @user_test = UserTest.find(params[:id])
    @test = Test.find(@user_test.test_id)
  end

  def new
    @test = Test.find_by_name(params[:test_name])
    @user_test = UserTest.new
  end

  def create
    @user_test = UserTest.new(user_test_params)
    @user_test.user = current_user
    @test = Test.find_by_name(params[:test_name])
    @user_test.test = @test
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
