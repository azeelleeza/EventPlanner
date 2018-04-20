class AmenitiesController < ApplicationController
  before_action :require_login
  before_action :set_amenity, only: [:show,:edit,:update,:destroy]

  def index
    @amenities = Amenity.all
  end

  def new
    @amenity = Amenity.new
  end

  def create
    @amenity = Amenity.create(name: params[:amenity][:name], description: params[:amenity][:description], price_in_cents: dollars_to_cents(params[:amenity][:price_in_cents]))
    if @amenity.valid?
      flash[:message] = "Successfully created event."
      redirect_to amenity_path(@amenity)
    else
      render :new
    end
  end

  def update
    @amenity.update(name: params[:amenity][:name], description: params[:amenity][:description], price_in_cents: dollars_to_cents(params[:amenity][:price_in_cents]))
    if @amenity.valid?
      flash[:message] = "Successfully updated event."

      redirect_to amenity_path
    else
      render :edit
    end
  end

  def destroy
    flash[:message] = "Successfully deleted event."

    @amenity.destroy
    redirect_to manage_amenities_path
  end

  private

  def require_login
    return head(:forbidden) unless session.include? :user_id
  end

  def dollars_to_cents(str)
    str.gsub(",", "").to_f.round(2)*100.to_i
  end

  def set_amenity
    @amenity = Amenity.find(params[:id])
  end

  def amenity_params
    params.require(:amenity).permit(Amenity.column_names)
  end
end
