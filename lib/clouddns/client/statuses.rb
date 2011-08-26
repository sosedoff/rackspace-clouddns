module CloudDns
  module Statuses
    # Check job status
    #
    # job_id - Job ID from AsyncResponse object
    #
    def status(job_id)
      get("/statuses/#{job_id}")
    end
  end
end
