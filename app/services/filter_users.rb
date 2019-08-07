class FilterUsers
  attr_reader :params

  def initialize(params)
    @params = params || {}
  end

  def search
    query = User.all

    query = filter_by_region(query)
    query = filter_by_age(query)
    query = filter_by_job_classification(query)
    query = filter_by_date_joined(query)
  end

  private

    def filter_by_region(query)
      if params[:region]
        query = query.where(region: params[:region].titlecase)
      end
      query
    end

    def filter_by_age(query)
      if params[:age]
        query = query.where(age: params[:age].titlecase)
      end
      query
    end

    def filter_by_job_classification(query)
      if params[:job_classification]
        query = query.where(job_classification: params[:job_classification].titlecase)
      end
      query
    end

    def filter_by_date_joined(query)
      # TO-DO: fix date search.
      if params[:date_joined]
        query = query.where(date_joined: params[:date_joined])
      end
      query
    end
end
