class ProfilesController < ApplicationController
  def index
    # Init data used to bootstrap Elm front-end application (SPA)
    @init_search = {
      searchQuery: "",
      searchPath: search_profiles_path,
      searchField: "fullname",
      searchResults: {
        profiles: [],
        pageInfo: { prevPage: 0, nextPage: 1, activated: false }
      }
    }
  end

  def search
    results = []

    page = params[:page] || 0
    page = page.to_i
    page = 0 if page < 0

    if %w(fullname skills).include?(params[:search_field])
      if params[:search_field] == "fullname"
        profiles = Profile.
                   where("LOWER(fullname) LIKE ?", "#{params['query'].downcase}%").
                   includes(:skills).page page
      else # search by skills
        profiles = Profile.
                   joins(:skills).
                   merge(Skill.where("name = ?", params['query'])).page page
      end
    end

    page_results = { profiles: profiles, pageInfo: page_info(page, profiles) }
    render json: { results: page_results }
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

    def page_info(page, records)
      prev_page = 0
      prev_page = page - 1 unless page.zero?

      nextPage = page + 1
      nextPage = 0 if records.count.zero?

      { prevPage: prev_page, nextPage: nextPage, activated: true }
    end
end
