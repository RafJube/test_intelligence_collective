class ModelsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @models = Model.all
    if user_signed_in?
      redirect_to models_path
    else
      @model = @models.first
      redirect_to modele_path(@model.name)
    end
  end

  def show
    @model = Model.find_by_name(params[:name])
    @model_names = Model.model_names
    if user_signed_in?
      render 'admin_modeles'
    else
      render 'modele'
    end
  end

  def new
    @model = Model.new
  end

  def create
    @model = Model.new(model_params)
    if @model.save
      redirect_to model_path(@model)
    else
      render :new
    end
  end

  def destroy
    @model = Model.find(params[:id])
    @model.destroy
    redirect_to models_path
  end

  def edit
    @model = Model.find(params[:id])
  end

  def update
    @model = Model.find(params[:id])
    @model.update(model_params)
    if @model.save
      redirect_to model_path(@model)
    else
      render :edit
    end
  end

  def to_param
    name
  end

  private

  def model_params
    params.require(:model).permit(:name, :surface, :rooms, :price, photo: [])
  end
end
