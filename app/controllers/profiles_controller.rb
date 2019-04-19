class ProfilesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    # Init data used to bootstrap Elm front-end application (SPA)
    @init_search = {
      searchQuery: "",
      searchPath: search_profiles_path,
      searchField: "fullname",
      searchResults: {
        profiles: [],
        pageInfo: { prevPage: 0, nextPage: 1, activated: false }
      },
      scrapeUrl: ""
    }
  end

  def search
    page = params[:page] || 0
    page = page.to_i
    page = 0 if page < 0

    if %w(fullname skills).include?(params[:search_field])
      query = params['query'].downcase
      if params[:search_field] == "fullname"
        profiles = MatViewProfile.
                   where("LOWER(fullname) LIKE ?", "#{query}%").page page
      else # search by skills
        profiles = MatViewProfile.
                   where("to_tsvector('english', skills) @@ to_tsquery(?)", query).page page
      end
    end

    page_results = { profiles: profiles, pageInfo: page_info(page, profiles) }
    render json: { results: page_results }
  end

  def create
    ProfileScrapingJob.perform_now(params[:url])
    render json: {status: "scrape request addded to job queue"}, status: :created
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
