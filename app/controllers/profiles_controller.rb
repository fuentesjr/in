class ProfilesController < ApplicationController
  def index
  end

  def search
    render json: {}
  end

  def create
    profile = Profile.new(profile_params)
    if profile.save
      render json: {status: :created}, status: :created
    else
      render json: {status: :unprocessable_entity}, status: :unprocessable_entity
    end
  end

  private

    def profile_params
      params.require(:profile).permit(:fullname, :title, :company, :position, :url)
    end
end
