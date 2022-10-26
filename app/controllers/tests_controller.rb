class TestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def show
    @test = Test.find_by_name(params[:name])
  end

  def to_param
    name
  end

  private

  def test_params
    params.require(:test).permit(:name)
  end
end
